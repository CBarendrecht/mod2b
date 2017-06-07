function Bam = bots(r1,r2,v1,v2,dt,R1,R2)
    Bam = false;
    Dv = v1(1,:)' - v2(1,:)';
    Dr = r1(1,:)' - r2(1,:)';
    t = (-Dv'*Dr)/(Dv'*Dv); %minimale afstand

    if 0 <= t && t <= dt
        if (Dr+Dv*t)'*(Dr+Dv*t) <(R1+R2)^2
            Bam = true;
        end
    end
end