clear all;
M = 1.99 * 10^30/(5.97 * 10^24);
n = 2 + 1;
A = zeros(5,n); %m,x,y,vx,vy
A(:,1) = [M,0,0,0,0];
A(:,2) = [1,-3,-2,baansnelheid([-3,-2])];
A(:,3) = [1,1,1,baansnelheid([1,1])];

dt = 1;
%%
while k < 10000
   B = A;
   for i = 1:n
       
   end
    
   k = k + 1;
end
