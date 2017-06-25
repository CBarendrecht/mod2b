clear all;

load('AP1000.mat');
AP1000 = AP;
clear AP;
load('AP1000controle.mat');
AP1000c = AP;
clear AP;

scatter(50:50:20000,AP1000,5,[0,0,1],'o');
hold on;
scatter(20050:50:30000,AP1000c,5,[0,0,1],'o');

title('Evolution of number of planets in time');
xlabel('Time in years');
ylabel('Mean number of planets conform our definition');
