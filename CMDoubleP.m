clc;
clear;
close all;
dt=0.001;
tf=40;
t=[0:dt:tf];
th1(1)=-pi/3; th2(1)=0;
dth1(1)=0; dth2(1)=0; L=0.4; R=0.1;lambda=0.1;m1=lambda*L; m2=lambda*2*pi*R;
g=9.81;
[ddth1(1),ddth2(1)]=penduloCM(th1,th2,dth1,dth2,L,R,m1,m2,g);
N=length(t);
for i=1:N-1;
    kth11=dth1(i);
    kth21=dth2(i);
 
        dkth11=ddth1(i);
        dkth21=ddth2(i);
    %
   kth12=kth11+dkth11*dt/2;
    kth22=kth21+dkth21*dt/2;
    [dkth12,dkth22]=penduloCM(th1(i)+kth11*dt/2,th2(i)+kth21*dt/2,kth12,kth22,L,R,m1,m2,g);
    %
        kth13=kth11+dkth12*dt/2;
    kth23=kth21+dkth22*dt/2;
    [dkth13,dkth23]=penduloCM(th1(i)+kth12*dt/2,th2(i)+kth22*dt/2,kth13,kth23,L,R,m1,m2,g);
    %
            kth14=kth11+dkth13*dt;
    kth24=kth21+dkth23*dt;
    [dkth14,dkth24]=penduloCM(th1(i)+kth13*dt,th2(i)+kth23*dt,kth14,kth24,L,R,m1,m2,g);
    %
    th1(i+1)=th1(i)+(dt/6)*(kth11+2*kth12+2*kth13+kth14);
    th2(i+1)=th2(i)+(dt/6)*(kth21+2*kth22+2*kth23+kth24);
    %
        dth1(i+1)=dth1(i)+(dt/6)*(dkth11+2*dkth12+2*dkth13+dkth14);
    dth2(i+1)=dth2(i)+(dt/6)*(dkth21+2*dkth22+2*dkth23+dkth24);
    %
    [ddth1(i+1),ddth2(i+1)]=penduloCM(th1(i+1),th2(i+1),dth1(i+1),dth2(i+1),L,R,m1,m2,g);
end
xd=L*sin(th1)/2;
yd=-L*cos(th1)/2;
x2=L*sin(th1)/2+R*sin(th2);
y2=-L*cos(th1)/2-R*cos(th2);
s=[0:pi/40:2*pi];
n=1;
fig=figure(1);
pause(1.2)
for i=1:40:N;
    C1=x2(i)+R*cos(s);
    C2=y2(i)+R*sin(s);
  plot([0,0],[0,-L-R],'-g','LineWidth',4)
  hold on
  plot([-L/6,L/6],[-L-R,-L-R],'-g','LineWidth',4)
    hold on
    plot(x2(1:i),y2(1:i),'-r','LineWidth',1.2)
    hold on
    plot([-xd(i) xd(i)],[-yd(i),yd(i)],'-b','LineWidth',10)
    hold on
    plot(C1,C2,'-b','LineWidth',10)
    hold off
    axis([1.3*(-R-L) 1.3*(R+L) -R-L (R+L)/2])
    set(gcf,'InvertHardCopy','off','Color','black');
    axis off
  frame=getframe(fig);
im=frame2im(frame); [imind,cm]=rgb2ind(im,256); imwrite(imind,cm,strcat(num2str(10000+n),'.png'));
n=n+1;
end
%%
d=0.2;
n=1002;
pause(3);
for k=1:60;
    C1=x2(i)+R*cos(s);
    C2=y2(i)+R*sin(s);
  plot([0,0],[0,-L-R],'-g','LineWidth',4)
  hold on
  plot([-L/6,L/6],[-L-R,-L-R],'-g','LineWidth',4)
    hold on
    plot(x2(1:i),y2(1:i),'-r','LineWidth',1.2)
    hold on
    plot([-xd(i) xd(i)],[-yd(i),yd(i)],'-b','LineWidth',10)
    hold on
    plot(C1,C2,'-b','LineWidth',10)
    hold off
    axis([1.3*(-R-L)+1.4*d*k/60 1.3*(R+L)-1.4*d*k/60 (-R-L)+d*k/60 (R+L)/2-d*k/60])
    set(gcf,'InvertHardCopy','off','Color','black');
    axis off
  frame=getframe(fig);
im=frame2im(frame); [imind,cm]=rgb2ind(im,256); imwrite(imind,cm,strcat(num2str(10000+n),'.png'));
n=n+1;
end