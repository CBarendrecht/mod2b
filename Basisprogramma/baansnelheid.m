function [v] = baansnelheid(x)
    M = 1.99 * 10^30;
    G = 6.67 * 10^-11;
    r =  sqrt(x(1)^2+x(2)^2);
    v = zeros(2,1);
    baanv = sqrt(G*M/r);
    v(2) = x(1)/r * baanv;
    v(1) = -x(2)/r * baanv;
end