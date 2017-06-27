function [m,M,r,x,v] = BigBangEllipse(n,minR,maxR,minM,maxM,T)
   
    m = zeros(n,1); %massavector
    M = zeros(n,2); %steenmassa || gasmassa
    r = zeros(n,1); %straalvector
    x = zeros(n,T,2); %plaatsarray: deeltjes - tijd - dimensie
    v = zeros(n,T,2); %snelheidarray: deeltjes - tijd - dimensie
    
    m(1) = 1.99 * 10^30/(5.97 * 10^24); %massa zon in aardmassa's
    r(1) = 6.96 * 10^8/(1.5*10^11); %straal zon
    
    for i = 2:n
        a = 5;%(maxR - minR)*rand + minR;
        b=4.9; %(maxR-  minR)*rand + maxR;
        c = 2*pi*rand;
        kansopgas = gampdf(a,6,2)*11;
        gas = binornd(1,kansopgas);
        m(i) = (maxM - minM)*rand + minM; 
        x(i,1,1) = a*cos(c); %x coordinaat
        x(i,1,2) = b*sin(c); %y coordinaat
        v(i,1,:) = baansnelheidEllipse([a*cos(c),b*sin(c)],a,b,c); %snelheid
        if gas
            M(i,1) = m(i)/100;
            M(i,2) = m(i) - M(i,1);
        else
            M(i,1) = m(i);
        end
        r(i) = straal(M(i,:)); %straal planeten
    end
    v(1,1,:) = -sum(m(2:n).*v(2:n,1,:))/m(1);
    x(1,1,:) = -sum(m(2:n).*x(2:n,1,:))/m(1);
end