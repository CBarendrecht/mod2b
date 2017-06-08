clear all;

prompt = {'Begin planeten','Eind planeten', 'Dataperiode','`Stapgrootte'};
dlg_title = 'Input';
num_lines = 1;
defaultans = {'500', '1500', '50','100'} ;
options.Resize = 'on';
answer = inputdlg(prompt,dlg_title,num_lines,defaultans,options);
p0 = str2num(answer{1}); %aantal simulaties
p1 = str2num(answer{2}); %periode van dataafname
dat = str2num(answer{3}); %jaren verdergaan
stapg = str2num(answer{4});
sim = (p1-p0)/stapg + 1;
    

[plan,dt,T,minR,maxR,minM,maxM] = Menu();%geen data, dus menu aanroepen
%aantal planeten
AP = zeros(ceil(T/(12*dat)),sim); %aantal planeten elke simulatie

%botsingen per meetinterval
BPM = zeros(ceil(T/(12*dat)),sim);

%straal
BEGINR = zeros(p1+1,sim);
EINDR = zeros(p1+1,sim);

%massa/types
BEGINM = zeros(p1+1,2,sim); %beginsituatie opslaan voor elke simulatie
EINDM = zeros(p1+1,2,sim); %beginsituatie opslaan voor elke simulatie

%omlooptijd planeten
OML = zeros(p1+1,sim);

%gemiddelde afstand
GEMafst = zeros(p1+1,sim);

%weggeschoten planeten
WEG = zeros(p1+1,sim);

%Behoud van impuls van guanyu
%IMPULS = zeros(T/(12*dat),(p1-p0)/100);

p=p0:100:p1;
for i = 1:length(p)
    [m,M,r,x,v,ap,beginM,beginr,bpm] = simulatie_nieuw2(p(i),dt,T,minR,maxR,minM,maxM,dat);
    BEGINM(1:p(i)+1,:,i) = beginM;
    BEGINR(1:p(i)+1,i) = beginr;
    EINDM(1:p(i)+1,:,i) = M;
    EINDR(1:p(i)+1,i) = r;
    AP(1:p(i)+1,i) = ap;
    BPM(1:p(i)+1,i) = bpm;
    %IMPULS(:,i) = im;
    
    %Als planneet verwegstaat is ie weg
    for j=1:p(i)+1
        if sum(M(j,:))>0 && x(j,T,1)^2 + x(j,T,2)^2 >4*maxR^2
                    WEG(j,i) = 1;
        end 
    end
    %berekent laatste omlooptijd planeten, onder aanname niet weggeschoten
    for j=1:p(i)+1
        %alle planeten
        if WEG(j,i)==0 && sum(M(j,:))>=0.06 && sum(M(j,:))<318*100
            %achterwaarts de tijd door
            for k = 1:T-1
                %net y-asgekruist
               if x(j,T+1-k,1)<0 && x(j,T-k,1)>0 && x(j,T+1-k,2) > 0
                   for g = k+1:T-1
                       %eerder de y-asgekruist
                       if x(j,T+1-g,1)<0 && x(j,T-g,1)>0 && x(j,T+1-g,2) > 0
                           OML(j,i) = g-k;
                           break;
                       end
                   end
                   break;
               end
            end
        end
    end
    
    %gemiddelde afstand tot de zon
    for j=2:p(i)+1
        if OML(j,i) > 0
            afst(1:OML(j,i)) = sqrt((x(j,T+1-OML(j,i):T,1)-x(1,T+1-OML(j,i):T,1)).^2 + (x(j,T+1-OML(j,i):T,2)-x(1,T+1-OML(j,i):T,2)).^2);
            GEMafst(j,i) = sum(afst)/OML(j,i);
            clear afst;
        end
    end
    
    %clear M;
    %clear r;
    %clear x;
    %clear v;
    clear bpm;
    clear ap;
    clear beginm;
    clear beginr;
    disp(['Simulatie met ' num2str(p(i)) 'planeten']);
end

