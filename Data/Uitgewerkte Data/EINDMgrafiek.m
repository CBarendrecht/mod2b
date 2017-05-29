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

MP100 = zeros(5,1);
MP200 = zeros(5,1);
MP300 = zeros(5,1);
MP400 = zeros(5,1);
MP500 = zeros(5,1);
MP600 = zeros(5,1);

for i = 1:5
    MP100(i) = mean(EINDM100(EINDM100(:,i) > 0.06,1,i));
    MP200(i) = mean(EINDM200(EINDM200(:,i) > 0.06,1,i));
    MP300(i) = mean(EINDM300(EINDM300(:,i) > 0.06,1,i));
    MP400(i) = mean(EINDM400(EINDM400(:,i) > 0.06,1,i));
    MP500(i) = mean(EINDM500(EINDM500(:,i) > 0.06,1,i));
    MP600(i) = mean(EINDM600(EINDM600(:,i) > 0.06,1,i));
end
MMP(1) = mean(MP100);
MMP(2) = mean(MP200);
MMP(3) = mean(MP300);
MMP(4) = mean(MP400);
MMP(5) = mean(MP500);
MMP(6) = mean(MP600);

scatter(100:100:600,MMP,5,[0,0,1],'o');
title('Mean mass of planets after 5000 years');
xlabel('Initial number of celestial bodies');
ylabel('Mean mass in');
