clear all; %we hebben tijd in maanden en afstand in AE
%[p,dt,T,minR,maxR,minM,maxM] = Menu();
%[m,M,r,x,v] = BigBang(n,minR,maxR,minM,maxM,T);
load('p=900_20000jaar.mat');
jaar = 5000;
T = ceil(jaar*12/dt);
n = 1+p; %aantal hemellichamen: zon + aantal planeten

x1(:,1,:) = xlast;
v1(:,1,:) = vlast;
x = zeros(n,T,2);
v = zeros(n,T,2);
x(:,1,:) = x1;
v(:,1,:) = v1;
clear x1;
clear v1;

figure('Name','Planets');
hold on;
scatter(x(1,1,1),x(1,1,2),10^4*r(1),[1,1,0],'filled');
scatter(x((m>0 & m<10^5),1,1),x((m>0 & m<10^5),1,2),10^5*r(m>0 & m<10^5),[1,0,0],'filled');
axis([-maxR-3 maxR+3 -maxR-3 maxR+3]);
pause(0.01);

B = largematrix;
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

J = 1:n;
Bots=largematrix;
botsarray = largematrix;

for k = 2:T
        B.array = zeros(10*n,8);
        Boommaken(B,A.array,0,0,5*maxR,1,1,m,x(:,k-1,:));
        Boomvullen(B,1);
        a = F2(B,x((m>0),k-1,:)); %versnelling op t = (k - 1) dt
        v((m > 0),k,:) = v((m > 0),k-1,:) + a*dt; %snelheid op t = (k - 1/2) dt
        
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
                        end
                    end
                end
            end
        end
        x((m > 0),k,:) = x((m > 0),k-1,:) + v((m > 0),k,:) * dt; %plaats op t = k dt
        a = [];
    
    cla;
    scatter(x(1,k,1),x(1,k,2),10^4*r(1),[1,1,0],'filled');
    scatter(x((m>0 & m<10^5),k,1),x((m>0 & m<10^5),k,2),10^5*r(m>0 & m<10^5),[1,0,0],'filled');
    pause(0.01);
    uicontrol('Style', 'text',...
       'String', ['Generation:', num2str(k)],... %replace something with the text you want
       'Units','normalized',...
       'Position', [0.9 0.9 0.1 0.1]);

    %disp(num2str(k));
    a=[];
end
hold off;


figure;
hold on;
for i = 1:n
    plot(x(i,:,1),x(i,:,2));
    
end
hold off;
axis([-maxR-1 maxR+1 -maxR-1 maxR+1]);


