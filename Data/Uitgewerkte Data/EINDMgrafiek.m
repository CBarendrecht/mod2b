clear all;
load('EINDM100.mat');
EINDM100 = sum(EINDM,2);
EINDSM100 = EINDM(:,1,:);
EINDGM100 = EINDM(:,2,:);
clear EINDM;
load('EINDM200.mat');
EINDM200 = sum(EINDM,2);
EINDSM200 = EINDM(:,1,:);
EINDGM200 = EINDM(:,2,:);
clear EINDM;
load('EINDM300.mat');
EINDM300 = sum(EINDM,2);
EINDSM300 = EINDM(:,1,:);
EINDGM300 = EINDM(:,2,:);
clear EINDM;
load('EINDM400.mat');
EINDM400 = sum(EINDM,2);
EINDSM400 = EINDM(:,1,:);
EINDGM400 = EINDM(:,2,:);
clear EINDM;
load('EINDM500.mat');
EINDM500 = sum(EINDM,2);
EINDSM500 = EINDM(:,1,:);
EINDGM500 = EINDM(:,2,:);
clear EINDM;
load('EINDM600.mat');
EINDM600 = sum(EINDM,2);
EINDSM600 = EINDM(:,1,:);
EINDGM600 = EINDM(:,2,:);
clear EINDM;
load('EINDM700.mat');
EINDM700 = sum(EINDM,2);
EINDSM700 = EINDM(:,1,:);
EINDGM700 = EINDM(:,2,:);
clear EINDM;
load('EINDM800.mat');
EINDM800 = sum(EINDM,2);
EINDSM800 = EINDM(:,1,:);
EINDGM800 = EINDM(:,2,:);
clear EINDM;
load('EINDM900.mat');
EINDM900 = sum(EINDM,2);
EINDSM900 = EINDM(:,1,:);
EINDGM900 = EINDM(:,2,:);
clear EINDM;

NGP100 = zeros(5,1);
NGP200 = zeros(5,1);
NGP300 = zeros(5,1);
NGP400 = zeros(5,1);
NGP500 = zeros(5,1);
NGP600 = zeros(5,1);
NGP700 = zeros(5,1);
NGP800 = zeros(5,1);
NGP900 = zeros(5,1);
MP100 = zeros(5,1);
MP200 = zeros(5,1);
MP300 = zeros(5,1);
MP400 = zeros(5,1);
MP500 = zeros(5,1);
MP600 = zeros(5,1);
MP700 = zeros(5,1);
MP800 = zeros(5,1);
MP900 = zeros(5,1);

for i = 1:5
    M100 = EINDM100(EINDM100(:,i) > 0.06,1,i);
    M200 = EINDM200(EINDM200(:,i) > 0.06,1,i);
    M300 = EINDM300(EINDM300(:,i) > 0.06,1,i);
    M400 = EINDM400(EINDM400(:,i) > 0.06,1,i);
    M500 = EINDM500(EINDM500(:,i) > 0.06,1,i);
    M600 = EINDM600(EINDM600(:,i) > 0.06,1,i);
    M700 = EINDM700(EINDM700(:,i) > 0.06,1,i);
    M800 = EINDM800(EINDM800(:,i) > 0.06,1,i);
    M900 = EINDM900(EINDM900(:,i) > 0.06,1,i);
    GM100 = EINDGM100(EINDM100(:,i) > 0.06,1,i);
    GM200 = EINDGM200(EINDM200(:,i) > 0.06,1,i);
    GM300 = EINDGM300(EINDM300(:,i) > 0.06,1,i);
    GM400 = EINDGM400(EINDM400(:,i) > 0.06,1,i);
    GM500 = EINDGM500(EINDM500(:,i) > 0.06,1,i);
    GM600 = EINDGM600(EINDM600(:,i) > 0.06,1,i);
    GM700 = EINDGM700(EINDM700(:,i) > 0.06,1,i);
    GM800 = EINDGM800(EINDM800(:,i) > 0.06,1,i);
    GM900 = EINDGM900(EINDM900(:,i) > 0.06,1,i);
    NGP100(i) = sum(GM100./M100 > 0.1);
    NGP200(i) = sum(GM200./M200 > 0.1);
    NGP300(i) = sum(GM300./M300 > 0.1);
    NGP400(i) = sum(GM400./M400 > 0.1);
    NGP500(i) = sum(GM500./M500 > 0.1);
    NGP600(i) = sum(GM600./M600 > 0.1);
    NGP700(i) = sum(GM700./M700 > 0.1);
    NGP800(i) = sum(GM800./M800 > 0.1);
    NGP900(i) = sum(GM900./M900 > 0.1);
    MP100(i) = mean(EINDM100(EINDM100(:,i) > 0.06,1,i));
    MP200(i) = mean(EINDM200(EINDM200(:,i) > 0.06,1,i));
    MP300(i) = mean(EINDM300(EINDM300(:,i) > 0.06,1,i));
    MP400(i) = mean(EINDM400(EINDM400(:,i) > 0.06,1,i));
    MP500(i) = mean(EINDM500(EINDM500(:,i) > 0.06,1,i));
    MP600(i) = mean(EINDM600(EINDM600(:,i) > 0.06,1,i));
    MP700(i) = mean(EINDM700(EINDM700(:,i) > 0.06,1,i));
    MP800(i) = mean(EINDM800(EINDM800(:,i) > 0.06,1,i));
    MP900(i) = mean(EINDM900(EINDM900(:,i) > 0.06,1,i));
    
    clear M100;
    clear M200;
    clear M300;
    clear M400;
    clear M500;
    clear M600;
    clear M700;
    clear M800;
    clear M900;
    clear GM100;
    clear GM200;
    clear GM300;
    clear GM400;
    clear GM500;
    clear GM600;
    clear GM700;
    clear GM800;
    clear GM900;
end

MMP(1) = mean(MP100);
MMP(2) = mean(MP200);
MMP(3) = mean(MP300);
MMP(4) = mean(MP400);
MMP(5) = mean(MP500);
MMP(6) = mean(MP600);
MMP(7) = mean(MP700);
MMP(8) = mean(MP800);
MMP(9) = mean(MP900);
MNGP(1) = mean(NGP100);
MNGP(2) = mean(NGP200);
MNGP(3) = mean(NGP300);
MNGP(4) = mean(NGP400);
MNGP(5) = mean(NGP500);
MNGP(6) = mean(NGP600);
MNGP(7) = mean(NGP700);
MNGP(8) = mean(NGP800);
MNGP(9) = mean(NGP900);

figure;
scatter(100:100:900,MMP,25,[0,0,1],'o','filled');
title('Mean mass of planets after 5000 years');
xlabel('Initial number of celestial bodies');
ylabel('Mean mass in earth masses');

figure;
scatter(100:100:900,MNGP,25,[0,0,1],'o','filled');
title('Mean number of gas planets after 5000 years');
xlabel('Initial number of celestial bodies');
ylabel('Number of gas planets');
