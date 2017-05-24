function [m,r,x,v] = BigBang(n,minR,maxR,minM,maxM,T)
   
    m = zeros(n,1); %massavector
    r = zeros(n,1); %straalvector
    x = zeros(n,T,2); %plaatsarray: deeltjes - tijd - dimensie
    v = zeros(n,T,2); %snelheidarray: deeltjes - tijd - dimensie
    
    m(1) = 1.99 * 10^30/(5.97 * 10^24); %massa zon in aardmassa's
    r(1) = 6.96 * 10^8/(1.5*10^11); %straal zon
    
    for i = 2:n
        b = (maxR - minR)*rand + minR;
        c = 2*pi*rand;
        m(i) = (maxM - minM)*rand + minM; %constante massa
        r(i) = straal(m(i)); %straal planeten
        x(i,1,1) = b*cos(c); %x coordinaat
        x(i,1,2) = b*sin(c); %y coordinaat
        v(i,1,:) = baansnelheid([b*cos(c),b*sin(c)]); %snelheid
    end
    v(1,1,:) = -sum(m(2:n).*v(2:n,1,:))/m(1);
    x(1,1,:) = -sum(m(2:n).*x(2:n,1,:))/m(1);
end