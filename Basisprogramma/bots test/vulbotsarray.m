function vulbotsarray(Boom,knoop,Bots,x,i,n)
Bots.array = zeros(1,n);
xmax = Boom.array(knoop,9);
xmin = Boom.array(knoop,10);
ymax = Boom.array(knoop,11);
ymin = Boom.array(knoop,12);
if x(1) <= xmax && x(1) >= xmin && x(2) <= ymax && x(2) >= ymin %botsing mogelijk
    if Boom.array(knoop,13) == 0
        vulbotsarray(Boom,Boom.array(knoop,1),Bots,x,i,n);
        vulbotsarray(Boom,Boom.array(knoop,2),Bots,x,i,n);
        vulbotsarray(Boom,Boom.array(knoop,3),Bots,x,i,n);
        vulbotsarray(Boom,Boom.array(knoop,4),Bots,x,i,n);
    else
        j = Boom.array(knoop,13);
        Bots.array(j) = 1;
    end
end
end