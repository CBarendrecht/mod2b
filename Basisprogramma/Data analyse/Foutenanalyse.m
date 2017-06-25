clear all; %we hebben tijd in maanden en afstand in AE
%[p,h,T,minR,maxR,minM,maxM] = Menu();
n = 2;
G = 6.67 * 10^-11/(1.5*10^11)^3 * 5.97 * 10^24 * (3600*2*365.25)^2;
T=1200;
minR=0.5;
maxR=0.5;
minM=1;
maxM=1;
Energie=zeros(1,7);
[m,M,r,x,v] = BigBang(n,minR,maxR,minM,maxM,T*4);
xbegin=x;
vbegin=v;
tel=1;
telE=1;
Q=zeros(2,3);
for h=1%,0.5,0.25]
x=xbegin;
v=vbegin;
if telE==1
Energie(1,telE)=1/2*dot(v(2,1,:),v(2,1,:))-G*m(1)/(sqrt(x(2,1,1)^2+x(2,1,2)^2));
end
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
v(:,2,:) = v(:,1,:) + h/2 * a; %snelheid op t = 1/2 h
x(:,2,:) = x(:,1,:) + v(:,2,:) * h; %plaats op t = h

cla;
scatter(x(1,2,1),x(1,2,2),10^4*r(1),[1,1,0],'filled');
scatter(x((m>0 & m<10^5),2,1),x((m>0 & m<10^5),2,2),10^5*r(m>0 & m<10^5),[1,0,0],'filled');
pause(0.01);

for k = 3:T/h
    B.array=zeros(10*n,8);
    Boommaken(B,A.array,0,0,5*maxR,1,1,m,x(:,k-1,:));
    Boomvullen(B,1);
    a = F2(B,x((m>0),k-1,:)); %versnelling op t = (k - 1) h
    v((m > 0),k,:) = v((m > 0),k-1,:) + a*h; %snelheid op t = (k - 1/2) h
    
    %botsen
    for i = 1:n-1
        if m(i) > 0
            for j = i+1:n
                if m(j) > 0 
                    if bots(x(i,k-1,:),x(j,k-1,:),v(i,k,:),v(j,k,:),h,r(i),r(j))
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
    
    x((m > 0),k,:) = x((m > 0),k-1,:) + v((m > 0),k,:) * h; %plaats op t = k h
    if(tel==1&&mod(k,100)==0)
        telE=telE+1;
        ve=v(2,k,:)+a(2,1,:)*h/2;
        Energie(1,telE)=1/2*dot(ve,ve)-G*m(1)/sqrt(x(2,k,1)^2+x(2,k,2)^2);
    end
    
    cla;
    scatter(x(1,k,1),x(1,k,2),10^4*r(1),[1,1,0],'filled');
    scatter(x((m>0 & m<10^5),k,1),x((m>0 & m<10^5),k,2),10^5*r(m>0 & m<10^5),[1,0,0],'filled');
    pause(0.01);
    uicontrol('Style', 'text',...
       'String', ['Generation:', num2str(k)],... %replace something with the text you want
       'Units','normalized',...
       'Position', [0.9 0.9 0.1 0.1]);

    %disp(num2str(k));
    %a=[];
end
hold off;


figure;
hold on;
for i = 1:n
    plot(x(i,1:T/h,1),x(i,1:T/h,2));
    
end
hold off;
axis([-maxR-1 maxR+1 -maxR-1 maxR+1]);
Q(:,tel)=x(2,T/h,:);
tel=tel+1;
end
ans=(Q(:,2)-Q(:,1))./(Q(:,3)-Q(:,2));
p=log(ans)./log(2);
