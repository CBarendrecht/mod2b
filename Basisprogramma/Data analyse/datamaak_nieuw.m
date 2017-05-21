clear all;
prompt = {'Aantal Simulaties'};
dlg_title = 'Input';
num_lines = 1;
defaultans = {'10'} ;
options.Resize = 'on';
answer = inputdlg(prompt,dlg_title,num_lines,defaultans,options);
sim = str2num(answer{1}); %aantal simulaties
[p,dt,T,minR,maxR,minM,maxM] = Menu();
BEGINM = zeros(sim,p+1); %beginsituatie opslaan voor elke simulatie
BEGINR = zeros(sim,p+1);
BEGINX = zeros(sim,p+1,2);
BEGINV = zeros(sim,p+1,2);
BPM = zeros(sim,T-1); %botsingen per maand elke simulatie
BOTS = zeros(sim,1); %totaal aantal botsingen elke simulatie
AP = zeros(sim,T); %aantal planeten elke simulatie

for i = 1:sim
    [m,r,x,v,bpm,ap,beginm,beginr] = simulatie_nieuw(p,dt,T,minR,maxR,minM,maxM);
    BEGINM(i,:) = beginm;
    BEGINR(i,:) = beginr;
    BEGINX(i,:,:) = x(:,1,:);
    BEGINV(i,:,:) = v(:,1,:);
    BPM(i,:) = bpm;
    BOTS(i) = sum(bpm);
    AP(i,:) = ap;
    
    clear m;
    clear r;
    clear x;
    clear v;
    clear bpm;
    clear ap;
    disp(num2str(i));
end

