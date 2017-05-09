function [y] = F(x,m,D)
    G = 6.67 * 10^-11/(1.5*10^11)^3 * 5.97 * 10^24 * (3600*2*365.25)^2; %grav const in AE^3/(maand^2 aardmassa)
    n = size(x);
    y = zeros(n);
    for i = 1:n(1)
        vw = (D(i,:)> 0.01); %anders wordt de versnelling te groot
        y(i,1) = sum(G * m(vw) .* ((x((vw),1) - x(i,1)).*(D((vw),i).^(-3/2))));
        y(i,2) = sum(G * m(vw) .* ((x((vw),2) - x(i,2)).*(D((vw),i).^(-3/2))));
    end
end