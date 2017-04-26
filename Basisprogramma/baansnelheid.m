function [v] = baansnelheid(x)
    M = 1.99 * 10^30;
    G = 6.67 * 10^-11;
    r =  sqrt(x(1)^2+x(2)^2)*1.5*10^11;
    v = zeros(1,2);
    baanv = sqrt(G*M/r);
    v(2) = x(1)*1.5*10^11/r * baanv;
    v(1) = -x(2)*1.5*10^11/r * baanv;
end