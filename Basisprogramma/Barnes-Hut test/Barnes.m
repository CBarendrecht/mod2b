function teller = Barnes(A,B,knoop,tel, condities,p)
    
    if condities(B.array(knoop,:),p) == true
        A.array(1,tel) = knoop;
        teller = tel+1; %teller geeft de zoveelde plaats op de matrix aan
    else
        teller =  Barnes(A,B,B.array(knoop,1),tel, condities,p);
        teller =  Barnes(A,B,B.array(knoop,2),teller, condities,p);
        teller =  Barnes(A,B,B.array(knoop,3),teller, condities,p);
        teller =  Barnes(A,B,B.array(knoop,4),teller, condities,p);
    end
end