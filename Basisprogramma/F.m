function [y] = F(x,m,D)
    G = 6.67 * 10^-11/(1.5*10^11)^3 * 5.97 * 10^24 * (3600*2*365.25)^2; %grav const in AE^3/(maand^2 aardmassa)
    n = size(x);
    y = zeros(n);
    for i = 1:n(1)
        y(i,1) = sum(G * m(D(i,:)> 0.1) .* ((x((D(i,:)> 0.1),1) - x(i,1)).*(D((D(i,:)> 0.1),i).^(-3/2))));
        y(i,2) = sum(G * m(D(i,:)> 0.1) .* ((x((D(i,:)> 0.1),2) - x(i,2)).*(D((D(i,:)> 0.1),i).^(-3/2))));
    end
end