clear all;
load('EINDM100.mat');
EINDM100 = sum(EINDM,2);
clear EINDM;
load('EINDM200.mat');
EINDM200 = sum(EINDM,2);
clear EINDM;
load('EINDM300.mat');
EINDM300 = sum(EINDM,2);
clear EINDM;
load('EINDM400.mat');
EINDM400 = sum(EINDM,2);
clear EINDM;
load('EINDM500.mat');
EINDM500 = sum(EINDM,2);
clear EINDM;
load('EINDM600.mat');
EINDM600 = sum(EINDM,2);
clear EINDM;
load('EINDM700.mat');
EINDM700 = sum(EINDM,2);
clear EINDM;
load('EINDM800.mat');
EINDM800 = sum(EINDM,2);
clear EINDM;
load('EINDM900.mat');
EINDM900 = sum(EINDM,2);
clear EINDM;
load('EINDM1000.mat');
EINDM1000 = sum(EINDM,2);
clear EINDM;

load('EINDR100.mat');
EINDR100 = EINDR;
clear EINDR;
load('EINDR200.mat');
EINDR200 = EINDR;
clear EINDR;
load('EINDR300.mat');
EINDR300 = EINDR;
clear EINDR;
load('EINDR400.mat');
EINDR400 = EINDR;
clear EINDR;
load('EINDR500.mat');
EINDR500 = EINDR;
clear EINDR;
load('EINDR600.mat');
EINDR600 = EINDR;
clear EINDR;
load('EINDR700.mat');
EINDR700 = EINDR;
clear EINDR;
load('EINDR800.mat');
EINDR800 = EINDR;
clear EINDR;
load('EINDR900.mat');
EINDR900 = EINDR;
clear EINDR;
load('EINDR1000.mat');
EINDR1000 = EINDR;
clear EINDR;

RP100 = zeros(5,1);
RP200 = zeros(5,1);
RP300 = zeros(5,1);
RP400 = zeros(5,1);
RP500 = zeros(5,1);
RP600 = zeros(5,1);
RP700 = zeros(5,1);
RP800 = zeros(5,1);
RP900 = zeros(5,1);
RP1000 = zeros(5,1);
MAXRP100 = zeros(5,1);
MAXRP200 = zeros(5,1);
MAXRP300 = zeros(5,1);
MAXRP400 = zeros(5,1);
MAXRP500 = zeros(5,1);
MAXRP600 = zeros(5,1);
MAXRP700 = zeros(5,1);
MAXRP800 = zeros(5,1);
MAXRP900 = zeros(5,1);
MAXRP1000 = zeros(5,1);

for i = 1:5
    RP100(i) = mean(EINDR100(EINDM100(:,i) > 0.06,i));
    RP200(i) = mean(EINDR200(EINDM200(:,i) > 0.06,i));
    RP300(i) = mean(EINDR300(EINDM300(:,i) > 0.06,i));
    RP400(i) = mean(EINDR400(EINDM400(:,i) > 0.06,i));
    RP500(i) = mean(EINDR500(EINDM500(:,i) > 0.06,i));
    RP600(i) = mean(EINDR600(EINDM600(:,i) > 0.06,i));
    RP700(i) = mean(EINDR700(EINDM700(:,i) > 0.06,i));
    RP800(i) = mean(EINDR800(EINDM800(:,i) > 0.06,i));
    RP900(i) = mean(EINDR900(EINDM900(:,i) > 0.06,i));
    RP1000(i) = mean(EINDR1000(EINDM1000(:,i) > 0.06,i));
    MAXRP100(i) = max(EINDR100(EINDM100(:,i) > 0.06,i));
    MAXRP200(i) = max(EINDR200(EINDM200(:,i) > 0.06,i));
    MAXRP300(i) = max(EINDR300(EINDM300(:,i) > 0.06,i));
    MAXRP400(i) = max(EINDR400(EINDM400(:,i) > 0.06,i));
    MAXRP500(i) = max(EINDR500(EINDM500(:,i) > 0.06,i));
    MAXRP600(i) = max(EINDR600(EINDM600(:,i) > 0.06,i));
    MAXRP700(i) = max(EINDR700(EINDM700(:,i) > 0.06,i));
    MAXRP800(i) = max(EINDR800(EINDM800(:,i) > 0.06,i));
    MAXRP900(i) = max(EINDR900(EINDM900(:,i) > 0.06,i));
    MAXRP1000(i) = max(EINDR1000(EINDM1000(:,i) > 0.06,i));
end
MRP(1) = mean(RP100);
MRP(2) = mean(RP200);
MRP(3) = mean(RP300);
MRP(4) = mean(RP400);
MRP(5) = mean(RP500);
MRP(6) = mean(RP600);
MRP(7) = mean(RP700);
MRP(8) = mean(RP800);
MRP(9) = mean(RP900);
MRP(10) = mean(RP1000);
MMAXRP(1) = mean(MAXRP100);
MMAXRP(2) = mean(MAXRP200);
MMAXRP(3) = mean(MAXRP300);
MMAXRP(4) = mean(MAXRP400);
MMAXRP(5) = mean(MAXRP500);
MMAXRP(6) = mean(MAXRP600);
MMAXRP(7) = mean(MAXRP700);
MMAXRP(8) = mean(MAXRP800);
MMAXRP(9) = mean(MAXRP900);
MMAXRP(10) = mean(MAXRP1000);

figure;
scatter(100:100:1000,MRP*1.5*10^8/(6.371*10^3),25,[0,0,1],'o','filled');
hold on;
scatter(100:100:1000,MMAXRP*1.5*10^8/(6.371*10^3),25,[0,1,0],'o','filled');
title('Mean radius of planets after 5000 years');
xlabel('Initial number of celestial bodies');
ylabel('Mean radius in earth radius');
legend('Mean','Maximum');