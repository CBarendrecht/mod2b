function [massa,middelx,middely,xmax,xmin,ymax,ymin] = Boomvullen(B,knoop)
    
    if B.array(knoop,5) == 0 %nog niet gevuld
        if B.array(knoop,1) ~= 0   %als (knoop,1) leeg dan lege knoop
          [m1,x1,y1,xmax1,xmin1,ymax1,ymin1] = Boomvullen(B,B.array(knoop,1));
          [m2,x2,y2,xmax2,xmin2,ymax2,ymin2] = Boomvullen(B,B.array(knoop,2));
          [m3,x3,y3,xmax3,xmin3,ymax3,ymin3] = Boomvullen(B,B.array(knoop,3));
          [m4,x4,y4,xmax4,xmin4,ymax4,ymin4] = Boomvullen(B,B.array(knoop,4));
          
          massa = m1+m2+m3+m4;
          middelx = (m1*x1+m2*x2+m3*x3+m4*x4)/massa;
          middely = (m1*y1+m2*y2+m3*y3+m4*y4)/massa;
          xmax = max([xmax1,xmax2,xmax3,xmax4]);
          xmin = min([xmin1,xmin2,xmin3,xmin4]);
          ymax = max([ymax1,ymax2,ymax3,ymax4]);
          ymin = min([ymin1,ymin2,ymin3,ymin4]);
          B.array(knoop,5) = massa;
          B.array(knoop,6) = middelx;
          B.array(knoop,7) = middely;
          B.array(knoop,9) = xmax;
          B.array(knoop,10) = xmin;
          B.array(knoop,11) = ymax;
          B.array(knoop,12) = ymin;
        else
            massa = 0;
            middelx = 0;
            middely = 0;
            xmax = 0;
            xmin = 0;
            ymax = 0;
            ymin = 0;
        end
        
    else
        massa =  B.array(knoop,5);
        middelx = B.array(knoop,6);
        middely =  B.array(knoop,7);
        xmax = B.array(knoop,9);
        xmin = B.array(knoop,10);
        ymax = B.array(knoop,11);
        ymin = B.array(knoop,12);
    end
end