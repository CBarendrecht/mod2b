function [y] = F2(Boom,x)
    G = 6.67 * 10^-11/(1.5*10^11)^3 * 5.97 * 10^24 * (3600*2*365.25)^2; %grav const in AE^3/(maand^2 aardmassa)
    n = size(x);
    y = zeros(n);
    n(2) = [];
    
    A = largematrix;


    for i = 1:n(1)    
        A.array = zeros(1,size(n,1));
        Barnes(A,Boom,1,1,i,x); %A.array wordt gevuld met de indices van knopen
        
        vwM = Boom.array(A.array,5);
        D=zeros(length(A.array),2);
        D(:,1) = Boom.array(A.array(:),6);
        D(:,2) = Boom.array(A.array(:),7);
        fixdit = ones(size(D));
        fixdit(:,1)=sqrt((D(:,1)-x(i,1)).^2+(D(:,2)-x(i,2)).^2).^(-3); 
        %afst=(sqrt(sum((D-fixdit(i,:)).^2,1))).^(-3);
        
        y(i,1,1) = sum(G * vwM .* (D(:,1) - x(i,1)).*fixdit(:,1));
        y(i,1,2) = sum(G * vwM .* (D(:,2) - x(i,2)).*fixdit(:,1));
    end
end