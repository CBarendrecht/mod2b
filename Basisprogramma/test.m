clear all; %we hebben tijd in maanden en afstand in AE
M = 1.99 * 10^30/(5.97 * 10^24); %massa zon in aardmassa's
n = 2 + 1; %aantal hemellichamen: zon + aantal planeten
dt = 1; %tijdstapgrootte in maanden
T = 100; %aantal tijdstappen

A = zeros(5,n); %m,x,y,vx,vy
A(:,1) = [M,0,0,0,0]; %zon
A(:,2) = [1,-3,-2,baansnelheid([-3,-2])];
A(:,3) = [1,1,1,baansnelheid([1,1])];

m = zeros(n,1); %massavector
r = zeros(n,1); %straalvector
x = zeros(n,T,2); %plaatsarray: deeltjes - tijd - dimensie
v = zeros(n,T,2); %snelheidarray: deeltjes - tijd - dimensie
D = zeros(n); %onderlinge afstand^2 array

for i = 1:n
    m(i) = A(1,i); %massa
    r(i) = straal(m(i));
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

a = F(x(:,1,:),m,D); %versnelling op t = 0
v(:,2,:) = v(:,1,:) + dt/2 * a; %snelheid op t = 1/2 dt
x(:,2,:) = x(:,1,:) + v(:,2,:) * dt; %plaats op t = dt

for i = 1:n
    for j = 1:n
        D(i,j) = (x(i,2,1)-x(j,2,1)).^2 + (x(i,2,2)-x(j,2,2)).^2;
    end
end

for k = 3:T
    a = F(x(:,k-1,:),m,D); %versnelling op t = (k - 1) dt
    v(:,k,:) = v(:,k-1,:) + a * dt; %snelheid op t = (k - 1/2) dt
    
    for i = 1:n-1
        for j = i+1:n
            if bots(x(i,k-1,:),x(j,k-1,:),v(i,k,:),v(j,k,:),dt,r(i),r(j))
                
            end
        end
    end
    
    x(:,k,:) = x(:,k-1,:) + v(:,k,:) * dt; %plaats op t = k dt
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



