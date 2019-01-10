function  [gu,guprime]= g_rt(X0,u,T,delta_T,MT,ml,L,g)





M=fix(T/delta_T);
z1(1)=X0(1);
z2(1)=X0(2);
w1(1)=0;
w2(1)=0;
for i=2:M
    z1(i)=z1(i-1)+z2(i-1)*delta_T; 
    A=(MT+ml)*g*sin(z1(i-1));
    B=ml*L*0.5*sin(2*z1(i-1))*z2(i-1)^2;
    D=MT*L+ml*L*sin(z1(i-1))^2;
    z2(i)=z2(i-1)+(A-B+u*cos(z1(i-1)))*delta_T/D;
   % z2(i)=z2(i-1)-(a*sin(z1(i-1))+b*z2(i-1)-u)*deltat;   
    w1(i)=w1(i-1)+w2(i-1)*delta_T;
    w2(i)=w2(i-1)+cos(z1(i-1))*delta_T/D;
end
gu=z1(M);
guprime=w1(M)*0.5;




    


