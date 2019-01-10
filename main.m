close all
dt=0.01; tf=25; alpha=35;

t=0:dt:tf;

N=size(t,2);

MT=1.0;
ml=0.2;
L=2.0;
g=9.81;

T=0.2;
delta_T=0.01*T;
X=zeros(2,N);
X(:,1)=[pi/12;0];

u(1)=0;



%% reference
for i=1:N
    ref(i)=-pi/6 + pi*sin(i*dt)/3;
    ref_dot(i)=0.8*pi*1/3*cos(i*dt)*dt*N/tf;
%     ref_dot(i)=0;
    r(i)=-pi/6 + pi*sin(i*dt+T)/3;     
end

%% main loop
for i=2:N
    
    xdot=dxdt(X(:,i-1),u(i-1),MT,ml,L,g);
    X(:,i)=X(:,i-1)+xdot*dt;

    [gu,guprime]=g_rt(X(:,i),u(i-1),T,delta_T,MT,ml,L,g);
    
   ref(i)=-pi/6 + 0.8*pi*sin(i*dt)/3;
    r(i)=-pi/6 + 0.8*pi*sin(i*dt+T)/3;
%     
    %balance pendulum up
%     ref(i)=0;
%     r(i)=0;
%     
%    ref(i)=-pi/6 + pi*sin(i*dt)/3;
%    r=-pi/6 + pi*sin(i*dt+T)/3;
%     
   %  above: get to 90 degrees  alpha>10
%     ref(i)=-pi/6 + pi*sin(i*dt)/12;
%   r=-pi/6 + pi*sin(i*dt+T)/12;
%   
  
    u(i)=u(i-1)+alpha*(r(i)-gu)*dt/guprime;
    
end


%% angle
figure(1);

plot(t(2:(N-1)),180/pi*ref(2:(N-1)),'LineWidth',1.5);
hold on
plot(t(2:(N-1)),180/pi*X(1,2:(N-1)),'LineWidth',1.5);
hold off
x1=xlabel('$Time~[s]$');
y1=ylabel('Angle $~[^\circ]$');
  set(x1,'Interpreter','latex')
 set(y1,'Interpreter','latex')
 
 leg1=legend('Reference angle','Pendulum angle');
 set(leg1,'Interpreter','latex')
 
set(gcf, 'color', 'none');
set(gca, 'color', 'none');
hold off

pbaspect([2.5 1 1])
fig.PaperUnits = 'inches';
print('angle','-dsvg','-r0')


%% angular velocity

figure(2);
plot (t,ref_dot,'LineWidth',1.5)
hold on
plot(t,X(2,:),'LineWidth',1.5);

x1=xlabel('$Time~[s]$');
y1=ylabel('Angular velocity $~[rad/sec]$');
  set(x1,'Interpreter','latex')
 set(y1,'Interpreter','latex')
 
 leg1=legend('Reference angular velocity','Pendulum angular velocity');
 set(leg1,'Interpreter','latex')
 
set(gcf, 'color', 'none');
set(gca, 'color', 'none');
hold off

pbaspect([2.5 1 1])
fig.PaperUnits = 'inches';
print('omega','-dsvg','-r0')


%% input 
figure(3);


plot(t,u,'LineWidth',1.5);

x1=xlabel('$Time~[s]$');
y1=ylabel('Input $~[N]$');

set(x1,'Interpreter','latex')
set(y1,'Interpreter','latex')
 
set(gcf, 'color', 'none');
set(gca, 'color', 'none');
hold off

pbaspect([2.5 1 1])
fig.PaperUnits = 'inches';
print('input','-dsvg','-r0')


%for i=1:N
    %ref(i)=r;
%end
%plot(ref);
%hold off


%% error
figure (4)
plot(t,180/pi*(X(1,:)-ref),'LineWidth',1.5)

x1=xlabel('$Time~[s]$');
y1=ylabel('Error $~[^\circ]$');

set(x1,'Interpreter','latex')
set(y1,'Interpreter','latex')
 
set(gcf, 'color', 'none');
set(gca, 'color', 'none');
hold off

pbaspect([2.5 1 1])
fig.PaperUnits = 'inches';
print('error','-dsvg','-r0')





