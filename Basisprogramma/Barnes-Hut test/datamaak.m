p=50;
dt=1;
T=12;
minR=1;
maxR=7;
k = 1;
D = zeros(100,11);
isplaneet = zeros(100,11);
aantalplaneten = zeros(1,11);
tel = 1;
n = 1+p;
[m1,r1,x1,v1] = BigBang(n,minR,maxR,T);
        for h = [dt dt/2]
           for k=1:10
                if(k==1)
                [m,r,x,v] = simulatie(p,h,T*dt/h,maxR,m1,r1,x1,v1);
                else
                [m,r,x,v] = simulatie(aantalplaneten(k-1),h,T*dt/h,maxR,m,r,x,v);
                end
                D(1:n,k) = x(:,T,1).^2+x(:,T,2).^2;
                isplaneet(1:n,k) = (m>=0.06 & m<318*100);
                aantalplaneten(k) = sum(isplaneet(:,k));
                Qx(1:n,k)=x(:,T/dt*h,1);
                Qy(1:n,k)=x(:,T/dt*h,2);
                disp('1 jaar later');
           end
        end
   