clear all;
load('AP100.mat');
AP100 = AP;
clear AP;
load('AP200.mat');
AP200 = AP;
clear AP;
load('AP300.mat');
AP300 = AP;
clear AP;
load('AP400.mat');
AP400 = AP;
clear AP;
load('AP500.mat');
AP500 = AP;
clear AP;
load('AP600.mat');
AP600 = AP;
clear AP;
load('AP700.mat');
AP700 = AP;
clear AP;
load('AP800.mat');
AP800 = AP;
clear AP;
load('AP900.mat');
AP900 = AP;
clear AP;
load('AP1000.mat');
AP1000 = AP;
clear AP;

scatter(10:10:5000,mean(AP100,2),5,[1,0,1],'o');
hold on;
scatter(10:10:5000,mean(AP200,2),5,[0.5,0,1],'o');
hold on;
scatter(10:10:5000,mean(AP300,2),5,[0,0,1],'o');
hold on;
scatter(10:10:5000,mean(AP400,2),5,[0,0.5,1],'o');
hold on;
scatter(10:10:5000,mean(AP500,2),5,[0,1,1],'o');
hold on;
scatter(10:10:5000,mean(AP600,2),5,[0,1,0],'o');
hold on;
scatter(10:10:5000,mean(AP700,2),5,[0.5,1,0],'o');
hold on;
scatter(10:10:5000,mean(AP800,2),5,[1,1,0],'o');
hold on;
scatter(10:10:5000,mean(AP900,2),5,[1,0.5,0],'o');
hold on;
scatter(10:10:5000,mean(AP1000,2),5,[1,0,0],'o');


title('Evolution of number of planets in time');
xlabel('Time in years');
ylabel('Mean number of planets conform our definition');
legend('Start with 100 celestial bodies','Start with 200 celestial bodies','Start with 300 celestial bodies','Start with 400 celestial bodies','Start with 500 celestial bodies','Start with 600 celestial bodies','Start with 700 celestial bodies','Start with 800 celestial bodies','Start with 900 celestial bodies','Start with 1000 celestial bodies');