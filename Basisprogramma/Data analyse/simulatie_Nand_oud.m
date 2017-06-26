function [m,M,r,x,v,ap,beginM,beginr,bpm,weg] = simulatie_Nand_oud(p,dt,T,minR,maxR,minM,maxM,dat,filenaam)
    k2 = 1; % meetpuntteller
    n = 1 + p; %aantal hemellichamen: zon + aantal planeten
    if strcmp(filenaam,'0.mat')
        [m,M,r,x,v] = BigBang(n,minR,maxR,minM,maxM,T);
    else
        T100 = T;
        load(filenaam);
        T = T100;
        x1(:,1,:) = xlast;
        v1(:,1,:) = vlast;
        x = zeros(n,T,2);
        v = zeros(n,T,2);
        x(:,1,:) = x1;
        v(:,1,:) = v1;
        clear x1;
        clear v1;
    end
    weg = zeros(length(M),1); %weggeschoten planeten
    beginM = M;
    beginr = r;
    
    %B = largematrix;
    %B.array = zeros(10*n,8);
    A = largematrix;
    A.array = ones(1,n);
    for u=1:length(m)
        if m(u) == 0
            A.array(u) = 0;
        end
    end
    %Boommaken(B,A.array,0,0,2*maxR,1,1,m,x(:,1,:));
    %Boomvullen(B(:,1,:),1);
    bpm = zeros(ceil(T/(12*dat)),1); %aantal botsingen per meetinterval
    ap = zeros(ceil(T/(12*dat)),1); %aantal planeten
    
    
    %a = F2(B,x(:,1,:)); %versnelling op t = 0
    if strcmp(filenaam,'0.mat')
        %v(:,2,:) = v(:,1,:) + dt/2 * a; %snelheid op t = 1/2 dt
        leapfrog = false;
    else %leapfrog al begonnen
        %v(:,2,:) = v(:,1,:)+a*dt;
        leapfrog = true;
    end
    %x(:,2,:) = x(:,1,:) + v(:,2,:) * dt; %plaats op t = dt
    
    %Botsboom initialisaties
    J = 1:n;
    Bots=largematrix;
    botsarray = largematrix;
   
    D = zeros(n);
    for i = 1:n
        for j = 1:n
            D(i,j) = (x(i,1,1)-x(j,1,1))^2 + (x(i,1,2)-x(j,1,2))^2;
        end
    end

    for k = 2:T
        %B.array = zeros(10*n,8);
        %Boommaken(B,A.array,0,0,5*maxR,1,1,m,x(:,k-1,:));
        %Boomvullen(B,1);
        a = F(x((m>0),k-1,:),m(m > 0),D(m > 0, m > 0)); %versnelling op t = (k - 1) dt
        if leapfrog
            v((m > 0),k,:) = v((m > 0),k-1,:) + a*dt; %snelheid op t = (k - 1/2) dt
        else
            v(:,k,:) = v(:,k-1,:) + dt/2 * a;
            leapfrog = true;
        end
        
        %botsen
        Bots.array = zeros(10*n,10);
        Botsboommaken(Bots,A.array,0,0,5*maxR,1,1,x(:,k-1,:),v(:,k,:),r,dt);
        Botsboomvullen(Bots,1);
        for i = 1:n-1
            if (abs(x(i,k-1,1)) > 5*maxR || abs(x(i,k-1,2)) > 5*maxR)
                m(i) = 0;
                M(i,:) = 0;
                A.array(i) = 0;
                weg(i) = 1;
            end
            if m(i) > 0
                if v(i,k,1)>=0
                    xmax = x(i,k-1,1)+r(i)+v(i,k,1)*dt;%xmax
                    xmin = x(i,k-1,1)-r(i);%xmin
                else
                    xmax = x(i,k-1,1)+r(i);%xmax
                    xmin = x(i,k-1,1)-r(i)+v(i,k,1)*dt;%xmin
                end
                if v(i,k,2)>=0
                    ymax = x(i,k-1,2)+r(i)+v(i,k,2)*dt;%ymax
                    ymin = x(i,k-1,2)-r(i);%ymin
                else
                    ymax = x(i,k-1,2)+r(i);%ymax
                    ymin = x(i,k-1,2)-r(i)+v(i,k,2)*dt;%ymin
                end
                botsarray.array = zeros(1,n);
                vulbotsarray(Bots,1,botsarray,[xmax xmin;ymax ymin]);
                for j = J(botsarray.array == 1)
                    if j>i && m(j) > 0
                        if bots(x(i,k-1,:),x(j,k-1,:),v(i,k,:),v(j,k,:),dt,r(i),r(j))
                            if m(i) > m(j)
                                v(i,k,:) = (m(i)*v(i,k,:) + m(j)*v(j,k,:))/(m(i)+m(j));
                                m(i) = m(i) + m(j); %nog aanpassen
                                M(i,:) = M(i,:) + M(j,:);
                                x(i,k-1,:) = (x(i,k-1,:) + x(j,k-1,:))/2;
                                m(j) = 0;
                                M(j,:) = 0;
                                A.array(j) = 0;
                            else
                                v(j,k,:) = (m(j)*v(j,k,:) + m(i)*v(i,k,:))/(m(j)+m(i));
                                m(j)= m(i) + m(j); %nog aanpassen
                                M(j,:) = M(i,:) + M(j,:);
                                x(j,k-1,:) = (x(j,k-1,:) + x(i,k-1,:))/2;
                                m(i) = 0;
                                M(i,:) = 0;
                                A.array(i) = 0;
                            end
                            r(i) = straal(M(i,:));
                            r(j) = straal(M(j,:));
                            bpm(k2) = bpm(k2) + 1;
                        end
                    end
                end
            end
        end
        x((m > 0),k,:) = x((m > 0),k-1,:) + v((m > 0),k,:) * dt; %plaats op t = k dt
        for i = 1:n
            if m(i) > 0
                for j = 1:n
                    if m(j) > 0
                        D(i,j) = (x(i,k,1)-x(j,k,1))^2 + (x(i,k,2)-x(j,k,2))^2;
                    end
                end
            end
        end
        if mod(k,12*dat) == 0 % een meting elke dat jaar
            isplaneet(1:n) = (m>=0.06 & m<318*100);
            ap(k2) = sum(isplaneet);
            k2 = k2+1;
            disp([num2str(k/12) ' jaar bezig']);
        end
    end
    disp(k);
end