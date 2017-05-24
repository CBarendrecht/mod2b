function [r] = straal(M)
    
    rA = 6.37*10^6/(1.5*10^11);
    r = rA * M^(1/3);
end