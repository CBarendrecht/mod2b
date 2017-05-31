clear all; %we hebben tijd in maanden en afstand in AE
[p,dt,T,minR,maxR,minM,maxM] = Menu();
n = 1+p; %aantal hemellichamen: zon + aantal planeten
%[m,M,r,x,v] = BigBang(n,minR,maxR,minM,maxM,T);
load('beginwaarden.mat');
m = beginm;
M = beginM;
r = beginr;
x = beginx;
v = beginv;

figure('Name','Planets');
hold on;
scatter(x(1,1,1),x(1,1,2),10^4*r(1),[1,1,0],'filled');
scatter(x((m>0 & m<10^5),1,1),x((m>0 & m<10^5),1,2),10^5*r(m>0 & m<10^5),[1,0,0],'filled');
axis([-maxR-3 maxR+3 -maxR-3 maxR+3]);
pause(0.01);

B = largematrix;
B.array=zeros(10*n,8);
A = largematrix;
A.array = ones(1,n);
Boommaken(B,A.array,0,0,2*maxR,1,1,m,x(:,1,:));
Boomvullen(B,1);


a = F2(B,x(:,1,:)); %versnelling op t = 0
v(:,2,:) = v(:,1,:) + dt/2 * a; %snelheid op t = 1/2 dt
x(:,2,:) = x(:,1,:) + v(:,2,:) * dt; %plaats op t = dt

cla;
scatter(x(1,2,1),x(1,2,2),10^4*r(1),[1,1,0],'filled');
scatter(x((m>0 & m<10^5),2,1),x((m>0 & m<10^5),2,2),10^5*r(m>0 & m<10^5),[1,0,0],'filled');
pause(0.01);

Bots = largematrix;
%Bots.array = zeros(10*n,10);
%Botsboommaken(Bots,A.array,0,0,2*maxR,1,1,x(:,1,:),v(:,1,:),r,dt);
%Botsboomvullen(Bots,1);
J = 1:n;
botsteller = 0;
for k = 3:T
    B.array=zeros(10*n,8);
    Boommaken(B,A.array,0,0,5*maxR,1,1,m,x(:,k-1,:));
    Boomvullen(B,1);
    a = F2(B,x((m>0),k-1,:)); %versnelling op t = (k - 1) dt
    v((m > 0),k,:) = v((m > 0),k-1,:) + a*dt; %snelheid op t = (k - 1/2) dt
    Bots.array = zeros(10*n,10);
    Botsboommaken(Bots,A.array,0,0,5*maxR,1,1,x(:,k-1,:),v(:,k,:),r,dt);
    Botsboomvullen(Bots,1);
    
    %botsen
    for i = 1:n-1
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
            botsarray = largematrix;
            botsarray.array = zeros(1,n);
            vulbotsarray(Bots,1,botsarray,[xmax xmin;ymax ymin]);
            %for j = J(botsarray.array == 1)
            for j = i+1:n
                if m(j) > 0 && j~=i
                    if bots(x(i,k-1,:),x(j,k-1,:),v(i,k,:),v(j,k,:),dt,r(i),r(j))
                        botsteller = botsteller+1;
                        disp(botsteller);
                        if botsarray.array(j)~= 1
                            disp('error');
                           pause(10); 
                        end
                        if m(i) > m(j)
                            v(i,k,:) = (m(i)*v(i,k,:) + m(j)*v(j,k,:))/(m(i)+m(j));
                            m(i) = m(i) + m(j); %nog aanpassen
                            M(i,:) = M(i,:) + M(j,:); 
                            x(i,k-1,:) = (x(i,k-1,:) + x(j,k-1,:))/2;
                            m(j) = 0;
                            M(j,:) = 0;
                            A.array(1,j) = 0;
                        else
                            v(j,k,:) = (m(j)*v(j,k,:) + m(i)*v(i,k,:))/(m(j)+m(i));
                            m(j) = m(i) + m(j); %nog aanpassen
                            M(j,:) = M(i,:) + M(j,:); 
                            x(j,k-1,:) = (x(j,k-1,:) + x(i,k-1,:))/2;
                            m(i) = 0;
                            M(i,:) = 0;
                            A.array(1,i) = 0;
                        end
                        r(i) = straal(M(i,:));
                        r(j) = straal(M(j,:));
                    end
                end
            end
        end
    end
    
    x((m > 0),k,:) = x((m > 0),k-1,:) + v((m > 0),k,:) * dt; %plaats op t = k dt

    
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


