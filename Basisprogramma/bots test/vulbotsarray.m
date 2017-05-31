function vulbotsarray(Bots,knoop,botsarray,x)
xmax = Bots.array(knoop,5);
xmin = Bots.array(knoop,6);
ymax = Bots.array(knoop,7);
ymin = Bots.array(knoop,8);
if x(1,2) <= xmax && x(1,1) >= xmin && x(2,2) <= ymax && x(2,1) >= ymin %botsing mogelijk
    if Bots.array(knoop,9) == 0 %interne knoop
        if Bots.array(knoop,1) ~= 0 %lege knopen doen we niets mee!
            vulbotsarray(Bots,Bots.array(knoop,1),botsarray,x);
            vulbotsarray(Bots,Bots.array(knoop,2),botsarray,x);
            vulbotsarray(Bots,Bots.array(knoop,3),botsarray,x);
            vulbotsarray(Bots,Bots.array(knoop,4),botsarray,x);
        end
    else %externe knoop
        botsarray.array(Bots.array(knoop,9)) = 1;
    end
end
end