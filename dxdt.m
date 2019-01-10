function xdot=dxdt(z,u,MT,ml,L,g)
        
    A=(MT+ml)*g*sin(z(1));
    B=ml*L*0.5*sin(2*z(1))*z(2)^2;
    D=MT*L+ml*L*sin(z(1))^2;
    xdot(1,1)=z(2);
    xdot(2,1)=(A-B+u*cos(z(1)))/D;
    
end