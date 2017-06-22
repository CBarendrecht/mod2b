clear all;
load('EINDM500.mat');
EINDM500 = sum(EINDM,2);
EINDSM500 = EINDM(:,1);
EINDGM500 = EINDM(:,2);
clear EINDM;
load('EINDM600.mat');
EINDM600 = sum(EINDM,2);
EINDSM600 = EINDM(:,1);
EINDGM600 = EINDM(:,2);
clear EINDM;
load('EINDM700.mat');
EINDM700 = sum(EINDM,2);
EINDSM700 = EINDM(:,1);
EINDGM700 = EINDM(:,2);
clear EINDM;
load('EINDM800.mat');
EINDM800 = sum(EINDM,2);
EINDSM800 = EINDM(:,1);
EINDGM800 = EINDM(:,2);
clear EINDM;
load('EINDM900.mat');
EINDM900 = sum(EINDM,2);
EINDSM900 = EINDM(:,1);
EINDGM900 = EINDM(:,2);
clear EINDM;
load('EINDM1000.mat');
EINDM1000 = sum(EINDM,2);
EINDSM1000 = EINDM(:,1);
EINDGM1000 = EINDM(:,2);
clear EINDM;
load('EINDM1100.mat');
EINDM1100 = sum(EINDM,2);
EINDSM1100 = EINDM(:,1);
EINDGM1100 = EINDM(:,2);
clear EINDM;
load('EINDM1200.mat');
EINDM1200 = sum(EINDM,2);
EINDSM1200 = EINDM(:,1);
EINDGM1200 = EINDM(:,2);
clear EINDM;
load('EINDM1300.mat');
EINDM1300 = sum(EINDM,2);
EINDSM1300 = EINDM(:,1);
EINDGM1300 = EINDM(:,2);
clear EINDM;
load('EINDM1400.mat');
EINDM1400 = sum(EINDM,2);
EINDSM1400 = EINDM(:,1);
EINDGM1400 = EINDM(:,2);
clear EINDM;
load('EINDM1500.mat');
EINDM1500 = sum(EINDM,2);
EINDSM1500 = EINDM(:,1);
EINDGM1500 = EINDM(:,2);
clear EINDM;

M500 = EINDM500(EINDM500 > 0.06,1); %tot massa planeten 
GM500 = EINDGM500(EINDM500 > 0.06,1); %gasmassa planeten
NGP(1) = sum(GM500./M500 > 0.1); %aantal planeten met minstens 0.1 gas
MP(1) = mean(M500); %gemiddelde massa planeten
MAXP(1) = max(M500); %max massa planeten
M600 = EINDM600(EINDM600 > 0.06,1); 
GM600 = EINDGM600(EINDM600 > 0.06,1); 
NGP(2) = sum(GM600./M600 > 0.1); 
MP(2) = mean(M600); 
MAXP(2) = max(M600);
M700 = EINDM700(EINDM700 > 0.06,1); 
GM700 = EINDGM700(EINDM700 > 0.06,1); 
NGP(3) = sum(GM700./M700 > 0.1); 
MP(3) = mean(M700); 
MAXP(3) = max(M700); 
M800 = EINDM800(EINDM800 > 0.06,1); 
GM800 = EINDGM800(EINDM800 > 0.06,1); 
NGP(4) = sum(GM800./M800 > 0.1); 
MP(4) = mean(M800); 
MAXP(4) = max(M800); 
M900 = EINDM900(EINDM900 > 0.06,1); 
GM900 = EINDGM900(EINDM900 > 0.06,1); 
NGP(5) = sum(GM900./M900 > 0.1); 
MP(5) = mean(M900); 
MAXP(5) = max(M900); 
M1000 = EINDM1000(EINDM1000 > 0.06,1); 
GM1000 = EINDGM1000(EINDM1000 > 0.06,1); 
NGP(6) = sum(GM1000./M1000 > 0.1); 
MP(6) = mean(M1000); 
MAXP(6) = max(M1000); 
M1100 = EINDM1100(EINDM1100 > 0.06,1); 
GM1100 = EINDGM1100(EINDM1100 > 0.06,1); 
NGP(7) = sum(GM1100./M1100 > 0.1); 
MP(7) = mean(M1100); 
MAXP(7) = max(M1100); 
M1200 = EINDM1200(EINDM1200 > 0.06,1); 
GM1200 = EINDGM1200(EINDM1200 > 0.06,1); 
NGP(8) = sum(GM1200./M1200 > 0.1); 
MP(8) = mean(M1200); 
MAXP(8) = max(M1200); 
M1300 = EINDM1300(EINDM1300 > 0.06,1); 
GM1300 = EINDGM1300(EINDM1300 > 0.06,1); 
NGP(9) = sum(GM1300./M1300 > 0.1); 
MP(9) = mean(M1300); 
MAXP(9) = max(M1300); 
M1400 = EINDM1400(EINDM1400 > 0.06,1); 
GM1400 = EINDGM1400(EINDM1400 > 0.06,1); 
NGP(10) = sum(GM1400./M1400 > 0.1); 
MP(10) = mean(M1400); 
MAXP(10) = max(M1400); 
M1500 = EINDM1500(EINDM1500 > 0.06,1); 
GM1500 = EINDGM1500(EINDM1500 > 0.06,1); 
NGP(11) = sum(GM1500./M1500 > 0.1); 
MP(11) = mean(M1500); 
MAXP(11) = max(M1500); 

figure;
scatter(500:100:1500,MP,25,[0,0,1],'o','filled');
hold on;
scatter(500:100:1500,MAXP,25,[0,1,0],'o','filled');
title('Mean mass of planets after 20000 years');
xlabel('Initial number of celestial bodies');
ylabel('Mean mass in earth masses');
legend('Mean','Maximum');

figure;
scatter(500:100:1500,NGP,25,[0,0,1],'o','filled');
title('Mean number of gas planets after 20000 years');
xlabel('Initial number of celestial bodies');
ylabel('Number of gas planets');
