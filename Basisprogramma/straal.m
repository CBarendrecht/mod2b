function [r] = straal(m) 
    rA = 6.37*10^6/(1.5*10^11);
    r = rA * m^(1/3);
end