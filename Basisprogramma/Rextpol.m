clear all; %we hebben tijd in maanden en afstand in AE
%[p,dt,T,minR,maxR] = Menu(); %aantal planeten, tijdstap, aantal stappen en
%min en max afstand tot zon
tel=1;
for dt = [0.5,0.25,0.125]
    p=1;
    T=24/dt;
    minR=1;
    maxR=1;
    n = 1 + p; %aantal hemellichamen: zon + aantal planeten
    [m,r,x,v] = BigBang(n,minR,maxR,T); %aanmaken massavector, straalvector
    %plaatsmatrix en snelheidsmatrix
    if tel==1
    Qrstart=x(:,1,:);
    Qvstart=v(:,1,:);
    Qmstart=m(:,1);
    end
    x(:,1,:)=Qrstart;%beginvoorwaarden moeten dezelfde zijn voor Richardson
    v(:,1,:)=Qvstart;
    m(:,1)=Qmstart;
    D = zeros(n); %onderlinge afstandsmatrix
    for i = 1:n
        for j = 1:n
            D(i,j) = (x(i,1,1)-x(j,1,1))^2 + (x(i,1,2)-x(j,1,2))^2;
        end
    end

    figure;
    scatter(x(1,1,1),x(1,1,2),10^4*r(1),[1,1,0],'filled');
    hold on;
    scatter(x((m>0 & m<10^5),1,1),x((m>0 & m<10^5),1,2),10^5*r(m>0 & m<10^5),[1,0,0],'filled');
    axis([-2 2 -2 2]);
    hold on;
    pause(0.25);

    a = F(x((m>0),1,:),m(m>0),D((m > 0),(m > 0))); %versnelling op t = 0
    v(:,2,:) = v(:,1,:) + dt/2 * a; %snelheid op t = 1/2 dt
    x(:,2,:) = x(:,1,:) + v(:,2,:) * dt; %plaats op t = dt

    for i = 1:n
        if m(i) > 0
            for j = 1:n
                if m(j) > 0
                    D(i,j) = (x(i,2,1)-x(j,2,1)).^2 + (x(i,2,2)-x(j,2,2)).^2;
                end
            end
        end
    end

    cla;
    scatter(x(1,2,1),x(1,2,2),10^4*r(1),[1,1,0],'filled');
    scatter(x((m>0 & m<10^5),2,1),x((m>0 & m<10^5),2,2),10^5*r(m>0 & m<10^5),[1,0,0],'filled');
    pause(0.25);

    for k = 3:T
        a = F(x((m > 0),k-1,:),m(m>0),D((m > 0),(m > 0))); %versnelling op t = (k - 1) dt
        v((m > 0),k,:) = v((m > 0),k-1,:) + a*dt; %snelheid op t = (k - 1/2) dt

        %botsen
        for i = 1:n-1
            for j = i+1:n
                if bots(x(i,k-1,:),x(j,k-1,:),v(i,k,:),v(j,k,:),dt,r(i),r(j))
                    if m(i) > m(j)
                        v(i,k,:) = (m(i)*v(i,k,:) + m(j)*v(j,k,:))/(m(i)+m(j));
                        m(i) = m(i) + m(j); %nog aanpassen
                        x(i,k-1,:) = (x(i,k-1,:) + x(j,k-1,:))/2;
                        m(j) = 0;
                    else
                        v(j,k,:) = (m(j)*v(j,k,:) + m(i)*v(i,k,:))/(m(j)+m(i));
                        m(j)= m(i) + m(j); %nog aanpassen
                        x(j,k-1,:) = (x(j,k-1,:) + x(i,k-1,:))/2;
                        m(i) = 0;
                    end
                    r(i) = straal(m(i));
                    r(j) = straal(m(j));
                end
            end
        end

        x((m > 0),k,:) = x((m > 0),k-1,:) + v((m > 0),k,:) * dt; %plaats op t = k dt
        for i = 1:n
            if m(i) > 0
                for j = 1:n
                    if m(j) > 0
                        D(i,j) = (x(i,k,1)-x(j,k,1))^2 + (x(i,k,2)-x(j,k,2))^2;
                    end
                end
            end
        end

        cla;
        scatter(x(1,k,1),x(1,k,2),10^4*r(1),[1,1,0],'filled');
        scatter(x((m>0 & m<10^5),k,1),x((m>0 & m<10^5),k,2),10^5*r(m>0 & m<10^5),[1,0,0],'filled');
        pause(0.25);
    end
    hold off;

    figure;
    for i = 1:n
        plot(x(i,:,1),x(i,:,2));
        hold on;
    end
    axis([-5 5 -5 5]);
    x(1,:,:)=[];
    Qx(:,tel)=x(:,T,1);
    Qy(:,tel)=x(:,T,2);
    tel=tel+1;
    AantalPlaneten(tel)=sum(m>=0.06)-sum(m>=318);%eisen planeten
end
Q = atan(Qx./Qy);
Mx=(4*Qx(:,1)-Q(:,2))/3;
My=(4*Qy(:,1)-Q(:,2))/3;
%px = round(log((Qx(2)-Qx(1))/(Qx(3)-Qx(2)))/log(2)); Orde is 2,want leapfrog, hoeft p
%niet te berekenen
%py = round(log((Qy(2)-Qy(1))/(Qy(3)-Qy(2)))/log(2));
%pp = round(log((Q(2)-Q(1))/(Q(3)-Q(2)))/log(2));


