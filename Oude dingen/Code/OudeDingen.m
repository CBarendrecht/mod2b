%M = 1.99 * 10^30/(5.97 * 10^24); %massa zon in aardmassa's

%dt = 1; %tijdstapgrootte in maanden
%T = 500; %aantal tijdstappen

%A = zeros(5,n); %m,x,y,vx,vy
%A(:,1) = [M,0,0,0,0]; %zon
%A(:,2) = [1,-1.5,-1,baansnelheid([-1.5,-1])];
%A(:,3) = [50,0,1.08,baansnelheid([0,1.1])];
%A(:,4) = [50,1,0,baansnelheid([1,0])];
%A(:,5) = [150,-0.7,-0.71,baansnelheid([-0.7,-0.7])];

for i = 2:n
    b = 1.5*rand+0.2;
    c = 2*pi*rand;
    A(:,i) = [50,b*cos(c),b*sin(c),baansnelheid([b*cos(c),b*sin(c)])];
end

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
