clear all

%% Define the LTI model of the multi-compartment system

% Model parameters

k12=0.5;
k13=0.5;
k3=0.5;
k23=0.5;

% Matrices A and B
A=[-k12-k13+1, 0, 0; k12, -k23+1, 0; k13, k23, -k3+1];
B=[0; 1; 0];

%% Check that the system is unreachable
Mr=[B A*B (A^2)*B];
det(Mr)

%% Check that any state with a nonzero entry x_1 is unreachable
% Indeed, if compartment 1 is empty at the beginning of the experiment (as
% required by the definition of reachable state) it will be empty forever. The reason is that 
% it cannot receive the
% drug neither from other compartments nor from inputs


%% Computation of the reachability form

% Change of coordinates in the state-space (see the lectures) 

r=rank(Mr); % r=2

% the first two columns of Mr are linearly independent
% the vector [1 0 0]' is clearly independent of these columns

iTr=[Mr(:,1:2),[1 0 0]'];
Tr=inv(iTr)

hA=Tr * A * iTr
hB=Tr * B

% The unreachable states hx in the new coordinates are [0 0 *]'. In the
% original coordinates one has x=inv(Tr)[0 0 *]', which gives [* 0 0]
% Check this property using hx=[0 0 1]'

hx=[0 0 1]';
x=iTr*hx

%% Define the new LTI model by adding input u1

B1=[1 0;0  1;0  0];


%% Check that the system is reachable
Mr=[B1 A*B1 (A^2)*B1];
rank(Mr)


%% Compute the input steering the origin to x3=[1/2 1 1]'

% following the proof of the reachability theorem, we have the relation
% x3=Mr*u
% u=[u_2;u_1;u_0]

% this is a "fat" linear system in the 6 unknowns composing u (note that each vector u_i has two elements) 
% The system has infinitely may solutions because Mr is full rank. We
% recover a solution  through least-squares

x3=[1/2 1 1]';
u=Mr\x3

% check the result
x3_check=Mr*u


