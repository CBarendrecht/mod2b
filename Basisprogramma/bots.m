function Bam = bots(r1,r2,v1,v2,dt,R1,R2)
    Bam = false;
    Dv = v1(1,:)' - v2(1,:)';
    Dr = r1(1,:)' - r2(1,:)';
    t = -Dv'*Dr;% minder delen meer beter
    
    if 0 <= t && t <= dt*(Dv'*Dv)
        if ((Dv'*Dv)*Dr + Dv*t)'*((Dv'*Dv)*Dr + Dv*t) < (R1+R2)^2
            Bam = true;
        end
    end
   
end