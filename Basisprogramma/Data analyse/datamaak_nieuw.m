clear all;

prompt = {'Aantal Simulaties', 'Dataperiode' };
dlg_title = 'Input';
num_lines = 1;
defaultans = {'10', '10'} ;
options.Resize = 'on';
answer = inputdlg(prompt,dlg_title,num_lines,defaultans,options);
sim = str2num(answer{1}); %aantal simulaties
dat = str2num(answer{2}); %periode van dataafname

[p,dt,T,minR,maxR,minM,maxM] = Menu();

BEGINM = zeros(p+1,2,sim); %beginsituatie opslaan voor elke simulatie
BEGINR = zeros(p+1,sim);
BEGINX = zeros(p+1,2,sim);
BEGINV = zeros(p+1,2,sim);
%BPM = zeros(T,sim); %botsingen per maand elke simulatie 
%BPP = zeros(T/dat,sim); %botsingen per periode elke simulatie
BOTS = zeros(1,sim); %totaal aantal botsingen elke simulatie
AP = zeros(T/(12*dat),sim); %aantal planeten elke simulatie
EINDM = zeros(p+1,2,sim); %beginsituatie opslaan voor elke simulatie
EINDR = zeros(p+1,sim);


for i = 1:sim
    [M,r,x,v,ap,beginM,beginr] = simulatie_nieuw(p,dt,T,minR,maxR,minM,maxM,dat);
    BEGINM(:,:,i) = beginM;
    BEGINR(:,i) = beginr;
    BEGINX(:,:,i) = x(:,1,:);
    BEGINV(:,:,i) = v(:,1,:);
    EINDM(:,:,i) = M;
    EINDR(:,i) = r;
   % BPM(:,i) = bpm;
   % for j = 1:T/(12*dat)
    %    BPP(j,i) = sum(BPM(i,(j-1)*dat+1:j*dat));
   % end
    %BOTS(i) = sum(bpm);
    AP(:,i) = ap;    
    
    
    clear M;
    clear r;
    %clear x;
    clear v;
    clear bpm;
    clear ap;
    clear beginm;
    clear beginr;
    disp(['simulatie: ' num2str(i)]);
end

