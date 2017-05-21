p = 1000;
dt = 1;
T = 1200;
minR = 1;
maxR = 7;
D = zeros(1000,10);
isplaneet = zeros(1000,10);
aantalplaneten = zeros(1,10);
k2 = 1;
n = 1+p;
telbots=zeros(1,10);
[m,r,x,v] = BigBang(n,minR,maxR,T);
h = dt;
%codes van simulaties
    B = largematrix;
    B.array=zeros(10*n,8);
    A = largematrix;
    A.array = ones(1,n);
    Boommaken(B,A.array,0,0,2*maxR,1,1,m,x(:,1,:));
    Boomvullen(B(:,1,:),1);
    telbotsen=0;

    a = F2(B,x(:,1,:)); %versnelling op t = 0
    v(:,2,:) = v(:,1,:) + h/2 * a; %snelheid op t = 1/2 dt
    x(:,2,:) = x(:,1,:) + v(:,2,:) * h; %plaats op t = dt

    for k = 3:T
        B.array=zeros(10*n,8);
        Boommaken(B,A.array,0,0,2*maxR,1,1,m,x(:,k-1,:));
        Boomvullen(B,1);
        a = F2(B,x((m>0),k-1,:)); %versnelling op t = (k - 1) dt
        v((m > 0),k,:) = v((m > 0),k-1,:) + a*h; %snelheid op t = (k - 1/2) dt
    
    %botsen
        for i = 1:n-1
            for j = i+1:n
                if bots(x(i,k-1,:),x(j,k-1,:),v(i,k,:),v(j,k,:),h,r(i),r(j))
                    if m(i) > m(j)
                        v(i,k,:) = (m(i)*v(i,k,:) + m(j)*v(j,k,:))/(m(i)+m(j));
                        m(i) = m(i) + m(j); %nog aanpassen
                        x(i,k-1,:) = (x(i,k-1,:) + x(j,k-1,:))/2;
                        m(j) = 0;
                        A.array(j) = 0;
                    else
                        v(j,k,:) = (m(j)*v(j,k,:) + m(i)*v(i,k,:))/(m(j)+m(i));
                        m(j)= m(i) + m(j); %nog aanpassen
                        x(j,k-1,:) = (x(j,k-1,:) + x(i,k-1,:))/2;
                        m(i) = 0;
                        A.array(i) = 0;
                    end
                    r(i) = straal(m(i));
                    r(j) = straal(m(j));
                    telbotsen=telbotsen+1;
                end
            end
        end

        x((m > 0),k,:) = x((m > 0),k-1,:) + v((m > 0),k,:) * h; %plaats op t = k dt
           if(mod(k,120)==0)%we maken observaties van ons zonnestelsel na elke 10 jaar
               D(1:n,k2,tel) = x(:,T,1).^2+x(:,T,2).^2;
                    isplaneet(1:n,k2,tel) = (m>=0.06 & m<318*100);
                    aantalplaneten(k2) = sum(isplaneet(:,k2));
                    Qx(1:n,k2)=x(:,k,1);
                    Qy(1:n,k2)=x(:,k,2);
                    telbots(1,k2)=telbots(1,k2)+telbotsen;
                    telbotsen=0;
                    figure;
                    scatter(x(1,k,1),x(1,k,2),10^4*r(1),[1,1,0],'filled');
                    hold on;
                    scatter(x((m>0 & m<10^5),k,1),x((m>0 & m<10^5),k,2),10^5*r(m>0 & m<10^5),[1,0,0],'filled');
                    axis([-maxR-3 maxR+3 -maxR-3 maxR+3]);
                    hold on;
                    pause(0.01);
                    disp('10 jaar later');
                    k2=k2+1;
           end
    end