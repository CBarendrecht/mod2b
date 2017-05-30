
function [Boom,teller] = boommaken (B,A, midx, midy, L, knoop, knoptel, m, x)
    n = length(A);
    if sum(A) == 1
        for j=1:n
            if A(1,j) == 1
                B(knoop,5) = m(j);
                B(knoop,6) = x(j,1);
                B(knoop,7) = x(j,2);
            end
        end
        Boom = B;
        teller = knoptel;
    elseif sum(A) == 0
           Boom = B;
           teller = knoptel;
    else
        A1 = zeros(1,n);
        A2 = zeros(1,n);
        A3 = zeros(1,n);
        A4 = zeros(1,n);
        
        B(knoop,1) = knoptel+1;
        B(knoop,2) = knoptel+2;
        B(knoop,3) = knoptel+3;
        B(knoop,4) = knoptel+4;
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
       [B1,teller] = boommaken(B,A1,(midx-L)/2,(midy+L)/2,L/2,knoptel+1,teller,m,x);
       [B2,teller] = boommaken(B1,A2,(midx+L)/2,(midy+L)/2,L/2,knoptel+2,teller,m,x);
       [B3,teller] = boommaken(B2,A3,(midx+L)/2,(midy-L)/2,L/2,knoptel+3,teller,m,x);
       [Boom,teller] = boommaken(B3,A4,(midx-L)/2,(midy-L)/2,L/2,knoptel+4,teller,m,x);
    end
        