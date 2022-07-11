function [ddth1,ddth2]=penduloCM(th1,th2,dth1,dth2,L,R,m1,m2,g);
aa1=m1*L^2/(m2*12);
aa2=R^2;
c1=(L*R*sin(th1-th2)/2*dth2^2+g*L*sin(th1))/2;
c2=(-L*R*sin(th1-th2).*dth1^2)/4+g*R*sin(th2);
A=(aa1+L^2/4); B=L*R*cos(th1-th2)/4; C=(aa2+R^2);
ddth2=(-A.*c2+B.*c1)./(C.*A-B.^2);
ddth1=(-c1-B.*ddth2)./A;
end