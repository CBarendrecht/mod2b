clear all; %we hebben tijd in maanden en afstand in AE
M = 1.99 * 10^30/(5.97 * 10^24); %massa zon in aardmassa's
n = 1 + 3; %aantal hemellichamen: zon + aantal planeten
dt = 1; %tijdstapgrootte in maanden
T = 50; %aantal tijdstappen

A = zeros(5,n); %m,x,y,vx,vy
A(:,1) = [M,0,0,0,0]; %zon
A(:,2) = [1,-3,-2,baansnelheid([-3,-2])];
A(:,3) = [50,0,1.1,baansnelheid([0,1.1])];
A(:,4) = [1,1,0,baansnelheid([1,0])];

m = zeros(n,1); %massavector
r = zeros(n,1); %straalvector
x = zeros(n,T,2); %plaatsarray: deeltjes - tijd - dimensie
v = zeros(n,T,2); %snelheidarray: deeltjes - tijd - dimensie
D = zeros(n); %onderlinge afstand^2 array

for i = 1:n
    m(i) = A(1,i); %massa
    r(i) = straal(m(i)); %straal planeten
    r(1) = 6.96 * 10^8/(1.5*10^11); %straal zon
    x(i,1,1) = A(2,i); %x coordinaat
    x(i,1,2) = A(3,i); %y coordinaat
    v(i,1,1) = A(4,i); %snelheid x richting
    v(i,1,2) = A(5,i); %snelheid y richting
end
for i = 1:n
    for j = 1:n
        D(i,j) = (x(i,1,1)-x(j,1,1))^2 + (x(i,1,2)-x(j,1,2))^2;
    end
end

a = F(x((m>0),1,:),m,D); %versnelling op t = 0
v(:,2,:) = v(:,1,:) + dt/2 * a; %snelheid op t = 1/2 dt
x(:,2,:) = x(:,1,:) + v(:,2,:) * dt; %plaats op t = dt

for i = 1:n
    for j = 1:n
        D(i,j) = (x(i,2,1)-x(j,2,1)).^2 + (x(i,2,2)-x(j,2,2)).^2;
    end
end

for k = 3:T
    a = F(x((m > 0),k-1,:),m,D((m > 0),(m > 0))); %versnelling op t = (k - 1) dt
    v((m > 0),k,:) = v((m > 0),k-1,:) + a * dt; %snelheid op t = (k - 1/2) dt
    
    %botsen
    for i = 1:n-1
        for j = i+1:n
            if bots(x(i,k-1,:),x(j,k-1,:),v(i,k,:),v(j,k,:),dt,r(i),r(j))
                if m(i)>m(j)
                    v(i,k,:)=(m(i)*v(i,k,:)+m(j)*v(j,k,:))/(m(i)+m(j));
                    m(i)= m(i)+m(j); %nog aanpassen
                    x(i,k-1,:)=(x(i,k-1,:)+x(j,k-1,:))/2;
                    m(j)=0;
                else
                    v(j,k,:)=(m(j)*v(j,k,:)+m(i)*v(i,k,:))/(m(j)+m(i));
                    m(j)= m(i)+m(j); %nog aanpassen
                    x(j,k-1,:)=(x(j,k-1,:)+x(i,k-1,:))/2;
                    m(i)=0;
                end
                r(i) = straal(m(i));
                r(j) = straal(m(j));
            end
        end
    end
    
    x((m > 0),k,:) = x((m > 0),k-1,:) + v((m > 0),k,:) * dt; %plaats op t = k dt
    for i = 1:n
        for j = 1:n
            D(i,j) = (x(i,k,1)-x(j,k,1))^2 + (x(i,k,2)-x(j,k,2))^2;
        end
    end

end

figure;
for i = 1:n
    plot(x(i,:,1),x(i,:,2));
    hold on;
end
axis([-4 4 -4 4]);

figure;
for k = 1:T
    scatter(x((m>0 & m<10^5),k,1),x((m>0 & m<10^5),k,2),10^4*r(m>0 & m<10^5),linspace(1,10,2));
    hold on;
end
axis([-4 4 -4 4]);

