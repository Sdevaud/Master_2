%% Declaration of variable
h = 0.1;
k12 = 0.5 * h;
k13 = 0.5 * h;
k23 = 0.5 * h;
k3 = 0.5 * h;

A=[-k12-k13+1, 0, 0; k12, -k23+1, 0; k13, k23, -k3+1];
B=[0; 1; 0];

Mr = [B A*B (A^2)*B];
det(Mr);

r=rank(Mr);

iTr=[Mr(:,1:2),[1 0 0]'];
Tr=inv(iTr);

hA=Tr * A * iTr;
hB=Tr * B;


hx=[0 0 1]';
x=iTr*hx;

B = [1; 0; 1];
Mr1 = [B A*B (A^2)*B];
r1 = rank(Mr1);
