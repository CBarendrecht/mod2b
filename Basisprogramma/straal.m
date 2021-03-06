function [r] = straal(M)
    %dichtheid schalingsfactor 5.6533*10^8
    rhos = 5.51*10^3 * 5.6533*10^8; %dichtheid aarde
    rhog = 0.687*10^3 * 5.6533*10^8;   %dichteid saturnus
    m = M(1)/rhos + M(2)/rhog;
    r = (3*m/(4*pi))^(1/3);
end