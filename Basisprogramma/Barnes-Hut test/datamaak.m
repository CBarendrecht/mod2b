[p,dt,T,minR,maxR] = Menu();
k = 1;
D = zeros(100,11);
isplaneet = zeros(100,11);
aantalplaneten = zeros(1,11);
tel = 1;
    for p=5:1:10
        n = 1+p;
        [m1,r1,x1,v1] = BigBang(n,minR,maxR,T);
        for h = [dt dt/2]
            [m,r,x,v] = simulatie(p,h,T*dt/h,maxR,m1,r1,x1,v1);
            D(1:n,k) = x(:,T,1).^2+x(:,T,2).^2;
            isplaneet(1:n,k) = (m>=0.06 & m<318*100);
            aantalplaneten(k) = sum(isplaneet(:,k));
            Qx(1:n,tel)=x(:,T/dt*h,1);
            Qy(1:n,tel)=x(:,T/dt*h,2);
            tel=tel+1;
            k = k+1;
        end
    end