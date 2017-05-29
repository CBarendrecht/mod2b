function teller = Boommaken(B,A, midx, midy, L, knoop, knoptel, m, x, v, r, dt)
    n = length(A);
    B.array(knoop,8) = L;
    if sum(A) == 1
        for j=1:n
            if A(1,j) == 1
                B.array(knoop,5) = m(j);   %massa vlakje
                B.array(knoop,6) = x(j,1); %massamiddel x
                B.array(knoop,7) = x(j,2); %massamiddel y
                B.array(knoop,13) = j;
                %bepaal grenzen voor bots
                if v(j,1)>=0
                    B.array(knoop,9) = x(j,1)+r(j)+v(j,1)*dt;%xmax
                    B.array(knoop,10) = x(j,1)-r(j);%xmin
                else
                    B.array(knoop,9) = x(j,1)+r(j);%xmax
                    B.array(knoop,10) = x(j,1)-r(j)+v(j,1)*dt;%xmin
                end
                if v(j,2)>=0
                    B.array(knoop,11) = x(j,2)+r(j)+v(j,2)*dt;%ymax
                    B.array(knoop,12) = x(j,2)-r(j);%ymin
                else
                    B.array(knoop,11) = x(j,2)+r(j);%ymax
                    B.array(knoop,12) = x(j,2)-r(j)+v(j,2)*dt;%ymin
                end
            end
        end
        teller = knoptel;
    elseif sum(A) == 0
           teller = knoptel;
    else
        A1 = zeros(1,n);
        A2 = zeros(1,n);
        A3 = zeros(1,n);
        A4 = zeros(1,n);
        
        B.array(knoop,1) = knoptel+1;
        B.array(knoop,2) = knoptel+2;
        B.array(knoop,3) = knoptel+3;
        B.array(knoop,4) = knoptel+4;
        teller = knoptel+4;
        for i = 1:n 
            if A(1,i) == 1
                if x(i,1)<= midx && x(i,2) >= midy
                    A1(1,i) = 1;
                elseif x(i,1) > midx && x(i,2) >= midy
                    A2(1,i) = 1; 
                elseif x(i,1) >= midx && x(i,2) < midy
                    A3(1,i) = 1;
                else 
                    A4(1,i) = 1;
                end
            end
        end
       teller = Boommaken(B,A1,midx-L/2,midy+L/2,L/2,knoptel+1,teller,m,x,v,r,dt);
       teller = Boommaken(B,A2,midx+L/2,midy+L/2,L/2,knoptel+2,teller,m,x,v,r,dt);
       teller = Boommaken(B,A3,midx+L/2,midy-L/2,L/2,knoptel+3,teller,m,x,v,r,dt);
       teller = Boommaken(B,A4,midx-L/2,midy-L/2,L/2,knoptel+4,teller,m,x,v,r,dt);
    end
end
        