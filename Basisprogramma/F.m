function [y] = F(x,m,D)
    G = 6.67 * 10^-11;
    n = size(x);
    y = zeros(n);
    for i = 1:n(1)
        y(i,1) = G * m(D(i,:)> 0.1) * (x((D(i,:)> 0.1),1) - x(i,1))./(D((D(i,:)> 0.1),i).^3);
        y(i,2) = G * m(D(i,:)> 0.1) * (x((D(i,:)> 0.1),2) - x(i,2))./(D((D(i,:)> 0.1),i).^3);
    end
    
end