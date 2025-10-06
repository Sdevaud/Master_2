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
C=[0 0 1/2];

%% observability (1)

O = obsv(A, C);
rank_O = rank(O);
n = size(A,1);

fprintf("O :\n");
disp(O);

fprintf("rank of O : %d   rank of A : %d\n", rank(O), n);

% the rank of O is not equal to the rank of A, so the system is
% unobservable

%% free state of the system (2)
k23 = 0.5;
% Update the matrix A with the new value of k23
A = [-k12-k13+1, 0, 0; k12, -k23+1, 0; k13, k23, -k3+1];
% Recalculate the observability matrix and its rank with the updated A
O = obsv(A, C);
rank_O = rank(O);

fprintf("rank of O : %d   rank of A : %d\n", rank(O), n);

lambda = eig(A);  
observable = true;

for i = 1:length(lambda)
    lam = lambda(i);
    M = [lam*eye(n) - A; C];
    rank_Oi = rank(M);
    fprintf("eig : %f \n", lam);
    
    if rank_Oi < n
        observable = false;
        fprintf("A is unobservable because for lambda = %f the rank of PBH is %d (not maximal)\n", lam, rank_Oi);
        break;
    end
end

if observable
    fprintf("The system is observable with the method of PBH.\n");
end

fprintf("O :\n");
disp(O);

%% Observable system
k23=1;
y=[0;0.75;0.625];
A=[-k12-k13+1, 0, 0; k12, -k23+1, 0; k13, k23, -k3+1];

% Recalculate the observability matrix and its rank with the updated A
O = obsv(A, C);
rank_O = rank(O);

fprintf("rank of O : %d   rank of A : %d\n", rank(O), n);

x0 = O\y;

disp("result of x0 : ");
disp(x0);
disp(O);
