clear all;
prompt = {'Aantal Simulaties', 'Dataperiode' };
dlg_title = 'Input';
num_lines = 1;
defaultans = {'10', '12'} ;
options.Resize = 'on';
answer = inputdlg(prompt,dlg_title,num_lines,defaultans,options);
sim = str2num(answer{1}); %aantal simulaties
dat = str2num(answer{2}); %periode van dataafname
[p,dt,T,minR,maxR,minM,maxM] = Menu();
BEGINM = zeros(sim,p+1); %beginsituatie opslaan voor elke simulatie
BEGINR = zeros(sim,p+1);
BEGINX = zeros(sim,p+1,2);
BEGINV = zeros(sim,p+1,2);
BPM = zeros(sim,T); %botsingen per maand elke simulatie 
BPP = zeros(sim,T/dat); %botsingen per periode elke simulatie
BOTS = zeros(sim,1); %totaal aantal botsingen elke simulatie
AP = zeros(sim,T); %aantal planeten elke simulatie

for i = 1:sim
    [m,r,x,v,bpm,ap,beginm,beginr] = simulatie_nieuw(p,dt,T,minR,maxR,minM,maxM);
    BEGINM(i,:) = beginm;
    BEGINR(i,:) = beginr;
    BEGINX(i,:,:) = x(:,1,:);
    BEGINV(i,:,:) = v(:,1,:);
    BPM(i,:) = bpm;
    for j = 1:T/dat
        BPP(i,j) = sum(BPM(i,(j-1)*dat+1:j*dat));
    end
    BOTS(i) = sum(bpm);
    AP(i,:) = ap;
    
    clear m;
    clear r;
    clear x;
    clear v;
    clear bpm;
    clear ap;
    clear beginm;
    clear beginr;
    disp(num2str(i));
end

