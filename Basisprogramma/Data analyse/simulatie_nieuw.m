function [M,r,x,v,ap,beginM,beginr] = simulatie_nieuw(p,dt,T,minR,maxR,minM,maxM,dat)

    k2 = 1; % meetpuntteller
    n = 1 + p; %aantal hemellichamen: zon + aantal planeten
    [m,M,r,x,v] = BigBang(n,minR,maxR,minM,maxM,T);
    beginM = M;
    beginr = r;
    
    B = largematrix;
    B.array = zeros(10*n,8);
    A = largematrix;
    A.array = ones(1,n);
    Boommaken(B,A.array,0,0,2*maxR,1,1,m,x(:,1,:));
    Boomvullen(B(:,1,:),1);
    %bpm = zeros(T,1); %aantal botsingen per maand
    ap = zeros(T/(12*dat),1); %aantal planeten
    
    
    a = F2(B,x(:,1,:)); %versnelling op t = 0
    v(:,2,:) = v(:,1,:) + dt/2 * a; %snelheid op t = 1/2 dt
    x(:,2,:) = x(:,1,:) + v(:,2,:) * dt; %plaats op t = dt
    

    for k = 3:T
        B.array = zeros(10*n,8);
        Boommaken(B,A.array,0,0,5*maxR,1,1,m,x(:,k-1,:));
        Boomvullen(B,1);
        a = F2(B,x((m>0),k-1,:)); %versnelling op t = (k - 1) dt
        v((m > 0),k,:) = v((m > 0),k-1,:) + a*dt; %snelheid op t = (k - 1/2) dt

        %botsen
        for i = 1:n-1
            if m(i) > 0
                for j = i+1:n
                    if m(j) > 0
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
                            %bpm(k) = bpm(k) + 1;
                        end
                    end
                end
            end
        end
        x((m > 0),k,:) = x((m > 0),k-1,:) + v((m > 0),k,:) * dt; %plaats op t = k dt
        a = [];
        if mod(k,12*dat) == 0 % een meting elke dat jaar
            isplaneet(1:n) = (m>=0.06 & m<318*100);
            ap(k2) = sum(isplaneet);
            k2 = k2+1;
            disp([num2str(k/12) ' jaar bezig']);
        end
    end
end