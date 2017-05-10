function Bam = bots(r1,r2,v1,v2,dt,R1,R2)
    Bam = false;
    Dv = v1 - v2;
    Dr = r1 - r2;
    t = -dot(Dv,Dr);% minder delen meer beter
    
    if 0 <= t && t <= dt*dot(Dv,Dv)
        if dot(dot(Dv,Dv)*Dr + Dv*t,dot(Dv,Dv)*Dr + Dv*t) < (R1+R2)^2
            Bam = true;
        end
    end
   
end