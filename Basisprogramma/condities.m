function voldaan = condities (Boom,knoop,p,x,theta) %theta<1/sqrt(3)
voldaan = false;
d = (x(p,1)-Boom.array(knoop,6))^2+(x(p,2)-Boom.array(knoop,7))^2;
s = %lengte knoop
if s/d < theta
    
end
end