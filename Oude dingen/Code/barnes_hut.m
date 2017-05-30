function F = barnes_hut(m,x,theta) %m is massavector, x is matrix met posities
%geeft matrix terug met voor elk lichaam de versnelling in x en y richting
L = max(x);
boomvullen(); %boomvullen nog maken

n = size(m);
for f = 1:n %voor elk deeltje
    boomloop(1);
    %loop boom door
    d = (Boom(1,6)-x(f,1))^2+(Boom(1,7)-x(f,2))^2;
    s = L;
    if s/d < theta
        %loop niet verder
        %tel versnelling op bij f
    else
        %recursie voor alle kinderen van knoop
    end
end
end
