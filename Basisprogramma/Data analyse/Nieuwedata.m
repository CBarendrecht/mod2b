clear all;

prompt = {'Begin planeten','Eind planeten', 'Dataperiode'};
dlg_title = 'Input';
num_lines = 1;
defaultans = {'500', '1500', '50'} ;
options.Resize = 'on';
answer = inputdlg(prompt,dlg_title,num_lines,defaultans,options);
p0 = str2num(answer{1}); %aantal simulaties
p1 = str2num(answer{2}); %periode van dataafname
dat = str2num(answer{3}); %jaren verdergaan
    

[plan,dt,T,minR,maxR,minM,maxM] = Menu();%geen data, dus menu aanroepen
%aantal planeten
AP = zeros(ceil(T/(12*dat)),(p1-p0)/100); %aantal planeten elke simulatie

%botsingen per meetinterval
BPM = zeros(ceil(T/(12*dat)),(p1-p0)/100);

%straal
BEGINR = zeros(p1+1,(p1-p0)/100);
EINDR = zeros(p1+1,(p1-p0)/100);

%massa/types
BEGINM = zeros(p1+1,2,(p1-p0)/100); %beginsituatie opslaan voor elke simulatie
EINDM = zeros(p1+1,2,(p1-p0)/100); %beginsituatie opslaan voor elke simulatie

%omlooptijd planeten
OML = zeros(p1+1,(p1-p0)/100);

%gemiddelde afstand
GEMafst = zeros(p1+1,(p1-p0)/100);

%weggeschoten planeten
WEG = zeros(p1+1,(p1-p0)/100);

p=p0:100:p1;
for i = length(p)
    [m,M,r,x,v,ap,beginM,beginr,bpm] = simulatie_nieuw2(p(i),dt,T,minR,maxR,minM,maxM,dat);
    BEGINM(:,:,i) = beginM;
    BEGINR(:,i) = beginr;
    EINDM(:,:,i) = M;
    EINDR(:,i) = r;
    AP(:,i) = ap;
    BPM(:,i) = bpm;
    
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

