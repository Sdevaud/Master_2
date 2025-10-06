% ME-422 Multivariable Control: Exercise session 2 
% Problem 3 - Satellite Simulation 

k=0.091;
b=0.0036;
T = 0.01;
J1=1;
J2=0.1;
A=[1 T 0 0;
    -T*k/J2 1-T*b/J2 T*k/J2 T*b/J2
    0 0 1 T
    T*k/J1 T*b/J1 -T*k/J1 1-T*b/J1];
B=[0 0 0 T*1/J1]';
C=[1 0 0 0];
D=0;
satell=ss(A,B,C,D,T);

%% (a) - Check unboundedness of modes

abs(eig(satell))
eig(satell)

% The system has two eigenvalues at 1 (the only ones that might 
% generate unbounded modes): 
%       test the dimension of the nullspace

[V]=null(A-eye(size(A,1)));

% V contains only one column vector, therefore dim(V)=1<2. 
% There is an unbounded mode

%% (b) - Analyze the free movement

tu=0:T:200;
u=0*tu;
x0=[0 0 0.1 0];
[y,t,x]=lsim(satell,u,tu,x0);
figure(1)
plot(t,y)
grid
title('Free movement - angular position of the second mass')

% An initial position different from 0 for the angle \theta_2 leads to 
% oscillations on \theta_1 that converge towards an asymptotic value 
% that is non-zero - new satellite setting
% The oscillations are due to the modes associated with the pair of poles 
% with magnitude <1 

%% (c) - Impulse response

[y,t,x]=impulse(satell,tu);
figure(2);clf;
plot(t,y)
grid
title('Impulse response - angular position of the second mass')
% The impulse response leads to a perpetual rotation of the satellite body

%% (d) - Impulse response with output as angular velocity

C=[0 1 0 0];
satell=ss(A,B,C,D,T);
[y,t,x]=impulse(satell,tu);
figure(3); clf;
plot(t,y)
grid
title('Impulse response - angular velocity of the second mass')

% Consistently with the result given in part (c) above, the angular
% velocity of the satellite settles at a constant







