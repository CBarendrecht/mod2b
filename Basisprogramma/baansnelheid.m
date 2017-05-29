function [v] = baansnelheid(x)
    M = 1.99 * 10^30/(5.97 * 10^24); %massa zon in AE
    G = 6.67 * 10^-11/(1.5*10^11)^3 * 5.97 * 10^24 * (3600*24*365.25/12)^2; %grav const in AE^3/(maand^2 aardmassa)
    r =  sqrt(x(1)^2+x(2)^2);
    v = zeros(1,2);
    baanv = sqrt(G*M/r);
    v(2) = x(1)/r * baanv;
    v(1) = -x(2)/r * baanv;
end