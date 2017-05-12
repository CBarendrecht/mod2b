function [massa,middelx,middely] = Boomvullen(B,m,x,knoop)
    
    if B.array(knoop,5) == 0 %nog niet gevuld
        if B.array(knoop,1) ~= 0   %als (knoop,1) leeg dan lege knoop
          [m1,x1,y1] = Boomvullen(B,m,x,B.array(knoop,1));
          [m2,x2,y2] = Boomvullen(B,m,x,B.array(knoop,2));
          [m3,x3,y3] = Boomvullen(B,m,x,B.array(knoop,3));
          [m4,x4,y4] = Boomvullen(B,m,x,B.array(knoop,4));
          
          massa = m1+m2+m3+m4;
          middelx = (m1*x1+m2*x2+m3*x3+m4*x4)/massa;
          middely = (m1*y1+m2*y2+m3*y3+m4*y4)/massa;
          B.array(knoop,5) = massa;
          B.array(knoop,6) = middelx;
          B.array(knoop,7) = middely;
        else
            massa = 0;
            middelx = 0;
            middely = 0;
        end
        
    else
        massa =  B.array(knoop,5);
        middelx = B.array(knoop,6);
        middely =  B.array(knoop,7);
    end
end