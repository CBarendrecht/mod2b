function [xmax,xmin,ymax,ymin] = Botsboomvullen(B,knoop)
    
    if B.array(knoop,5) == 0 %nog niet gevuld
        if B.array(knoop,1) ~= 0   %als (knoop,1) leeg dan lege knoop
          [xmax1,xmin1,ymax1,ymin1] = Botsboomvullen(B,B.array(knoop,1));
          [xmax2,xmin2,ymax2,ymin2] = Botsboomvullen(B,B.array(knoop,2));
          [xmax3,xmin3,ymax3,ymin3] = Botsboomvullen(B,B.array(knoop,3));
          [xmax4,xmin4,ymax4,ymin4] = Botsboomvullen(B,B.array(knoop,4));
          
          xmax = max([xmax1,xmax2,xmax3,xmax4]);
          xmin = min([xmin1,xmin2,xmin3,xmin4]);
          ymax = max([ymax1,ymax2,ymax3,ymax4]);
          ymin = min([ymin1,ymin2,ymin3,ymin4]);
          B.array(knoop,5) = xmax;
          B.array(knoop,6) = xmin;
          B.array(knoop,7) = ymax;
          B.array(knoop,8) = ymin;
        else
            xmax = -Inf;
            xmin = Inf;
            ymax = -Inf;
            ymin = Inf;
        end
        
    else
        xmax = B.array(knoop,5);
        xmin = B.array(knoop,6);
        ymax = B.array(knoop,7);
        ymin = B.array(knoop,8);
    end
end