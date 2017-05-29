function vulbotsarray(Boom,knoop,Bots,x)
xmax = Boom.array(knoop,9);
xmin = Boom.array(knoop,10);
ymax = Boom.array(knoop,11);
ymin = Boom.array(knoop,12);
%disp([xmax xmin ymax ymin]);
%disp(x);
if x(1,2) <= xmax && x(1,1) >= xmin && x(2,2) <= ymax && x(2,1) >= ymin %botsing mogelijk
    if Boom.array(knoop,13) == 0 %interne knoop
        if Boom.array(knoop,1) ~= 0 %lege knopen doen we niets mee!
            vulbotsarray(Boom,Boom.array(knoop,1),Bots,x);
            vulbotsarray(Boom,Boom.array(knoop,2),Bots,x);
            vulbotsarray(Boom,Boom.array(knoop,3),Bots,x);
            vulbotsarray(Boom,Boom.array(knoop,4),Bots,x);
        end
    else %externe knoop
        Bots.array(Boom.array(knoop,13)) = 1;
    end
end
end