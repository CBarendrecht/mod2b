function teller = Barnes(A,B,knoop,tel,p,x)
    
 
    if condities(B,knoop,p,x) == true
        A.array(1,tel) = knoop;
        teller = tel+1; %teller geeft de zoveelde plaats op de matrix aan
    elseif B.array(knoop,1) ~= 0
        teller =  Barnes(A,B,B.array(knoop,1),tel,p,x);
        teller =  Barnes(A,B,B.array(knoop,2),teller,p,x);
        teller =  Barnes(A,B,B.array(knoop,3),teller,p,x);
        teller =  Barnes(A,B,B.array(knoop,4),teller,p,x);
    elseif B.array(knoop,5) ~= 0 && (B.array(knoop,6)- x(p,1))^2+(B.array(knoop,7)- x(p,2))^2 > 0.01 %in dit geval zit je in een blad
        A.array(1,tel) = knoop;
        teller = tel+1;
    else
        teller = tel;
    end
    
end