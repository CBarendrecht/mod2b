clear all;

prompt = {'Aantal Simulaties', 'Dataperiode', 'Laad data uit filenaam', 'Aantal jaar verder'};
dlg_title = 'Input';
num_lines = 1;
defaultans = {'1', '50', '0.mat', '1000'} ;
options.Resize = 'on';
answer = inputdlg(prompt,dlg_title,num_lines,defaultans,options);
sim = str2num(answer{1}); %aantal simulaties
dat = str2num(answer{2}); %periode van dataafname
T1 = str2num(answer{4}); %jaren verdergaan
filenaam = answer{3};
filenaam1 = filenaam;
if ~strcmp(filenaam,'0.mat')
    load(filenaam1);
    T = T1*12/dt;
else
    [p,dt,T,minR,maxR,minM,maxM] = Menu();%geen data, dus menu aanroepen
end
%aantal planeten
AP = zeros(ceil(T/(12*dat)),sim); %aantal planeten elke simulatie

%botsingen per meetinterval
BPM = zeros(ceil(T/(12*dat)),sim);

%straal
BEGINR = zeros(p+1,sim);
EINDR = zeros(p+1,sim);

%massa/types
BEGINM = zeros(p+1,2,sim); %beginsituatie opslaan voor elke simulatie
EINDM = zeros(p+1,2,sim); %beginsituatie opslaan voor elke simulatie

%omlooptijd planeten
OML = zeros(p+1,sim);

%gemiddelde afstand
GEMafst = zeros(p+1,sim);

%weggeschoten planeten
WEG = zeros(p+1,sim);


for i = 1:sim
    [m,M,r,x,v,ap,beginM,beginr,bpm] = simulatie_nieuw2(p,dt,T,minR,maxR,minM,maxM,dat,filenaam1);
    
    BEGINM(:,:,i) = beginM;
    BEGINR(:,i) = beginr;
    EINDM(:,:,i) = M;
    EINDR(:,i) = r;
    AP(:,i) = ap;
    BPM(:,i) = bpm;
    
    %Als planneet verwegstaat is ie weg
    for j=1:p+1
        if sum(M(j,:))>0 && x(j,T,1)^2 + x(j,T,2)^2 >4*maxR^2
                    WEG(j,i) = 1;
        end 
    end
    %berekent laatste omlooptijd planeten, onder aanname niet weggeschoten
    for j=1:p+1
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
    for j=2:p+1
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
    disp(['simulatie: ' num2str(i)]);
end

