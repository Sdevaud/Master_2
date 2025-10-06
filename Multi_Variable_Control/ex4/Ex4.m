clear all

%% Define the LTI model of the multi-compartment system

% Model parameters

k12=0.5;
k13=0.5;
k3=0.5;
k23=0;

% Matrices A, B and C
A=[-k12-k13+1, 0, 0; k12, -k23+1, 0; k13, k23, -k3+1];
B=[1 0;0  1;0 0];
C=[0 0 1/2]

%% Check that the system is unobservable
Ct=C';
At=A';

Mo=[Ct At*Ct (At^2)*Ct];
det(Mo)

%% Check that any initial state x0=[0 * 0]' is unobservable
% Indeed, compartment 2 does not influence compartment 3 (which is the only
% one defining the output), neither directly nor through compartment 


%% Simulate the free state of the system from x0=[0 * 0]'
% Show that y[k] = 0 for all k = {0,1,2,3} with k <= n = 3

x0 = [0 1 0]';
M = [Mo' ; C*A^3];
y = M*x0
plot(0:3,y);


%% Define the new LTI model by setting k23=0.5

k23=0.5;

% Matrix A
A1=[-k12-k13+1, 0, 0; k12, -k23+1, 0; k13, k23, -k3+1];
%% Check that the system is unobservable
Ct=C';
A1t=A1';

Mo=[Ct A1t*Ct (A1t^2)*Ct];
det(Mo)


%% Compute the unobservable eigenvalue using the PBH test

eigA1=eig(A1)

% storeplace for ranks of matrices involved in PBH tests
rk=zeros(3,1);
for i=1:3
    test=[eigA1(i)*eye(3)-A1;C];
    rk(i)=rank(test);
end

rk
eigA1
% only the rank corresponding to the null eigenvalue is not maximal -> this
% eigenvalue is unobservable

    
%% Compute the observability form of the system
% Change of coordinates in the state-space (see the lectures) 

r=rank(Mo); % r=2

% the last two columns of Mo' are linearly independent
% the vector [1 0 0]' is clearly independent of these columns
Mot=Mo';

% compute a basis for the unobservable subspace
V=null(Mot);

% compute a basis for the range of Mo. By construction, these vectors are orthogonal
% to V
Z=orth(Mo)

iTo=[Z, V];
To=inv(iTo)

hA1=To * A1 * iTo
hC=C*iTo

% The lower-right block of hA1 contains the zero eigenvalue -> this
% confirms the result of the PBH test


%% Simulate the free state of the system from x0=V, which is an unobservable state
% Show that y[k] = 0 for all k = {0,1,2,3} with k <= n = 3

x0 = V;
M = [Mot ; C*A1^3];
y = M*x0
plot(0:3,y);


%% Define the new LTI model by setting k23=1

k23=1;

% Matrix A
A2=[-k12-k13+1, 0, 0; k12, -k23+1, 0; k13, k23, -k3+1];
%% Check that the system is observable
Ct=C';
A2t=A2';

Mo=[Ct A2t*Ct (A2t^2)*Ct];
det(Mo)

%% Compute the initial state
y=[0;0.75;0.625]

%Solve the linear system (Mo')*x0=y
Mot=Mo';
x0=Mot\y

disp(Mo);

% One finds x0=[1 1 0] '