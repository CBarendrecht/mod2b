function a = condities(B,knoop,p,x)
    D = (B.array(knoop,6)- x(p,1))^2+(B.array(knoop,7)- x(p,2))^2;
    if D == 0
        a = false;
    else
        if B.array(knoop,8)^2/D < 1/4
            a = true;
        else 
            a = false;
        end
    end
end