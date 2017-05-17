function datamaak()
[p,dt,T,minR,maxR] = Menu();
aantplaneten = zeros(11,1);
regions = zeros(11,20);
k = 1;
for p=500:100:1500
    [m,x,r] = simulatie(p,dt,T,minR,maxR);
    aantplaneten(k) = sum(m>=0.06)-sum(m>=318*100);
    for r=1:20
        regions(k,r) = sum(x(m>=0.06&m<=318*100,floor(T/dt),1)^2+x(m>=0.06&m<=318*100,floor(T/dt),2)^2<=(r+1)^2 ...
        & x(m>=0.06&m<=318*100,floor(T/dt),1)^2+x(m>=0.06&m<=318*100,floor(T/dt),2)^2 >= r^2);
    end
    k = k+1;
end
end