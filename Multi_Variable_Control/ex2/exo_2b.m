%% Initiliase value
l = 1;
alpha = 16;
m = 2;
k = 4;
g = 9.81;


%% Compute equilibrum state (1)
x1 = linspace(-2,2,51);
plot(x1, g/l*sin(x1), x1, alpha/(m*l^2)*x1);
xlabel("x_1");
legend('$$\frac{g}{l}\sin(x_1)$$', '$$\frac{\alpha}{ml^2}x_1$$', 'Interpreter','latex');

syms x1
x_root = vpasolve(g/l*sin(x1) - alpha/(m*l^2)*x1, 1);
x_root = double(x_root);

xbar_0 = [0,0];
xbar_1 = [x_root,0];
xbar_2 = [-x_root,0];

%% Linearize the system (2)

linsys(1).xbar = xbar_0;
linsys(2).xbar = xbar_1;
linsys(3).xbar = xbar_2;
for i=1:3
    x_init = linsys(i).xbar;
    sim('duffingNL');
    linsys(i).A = duffingNL_Timed_Based_Linearization.a;
    linsys(i).B = duffingNL_Timed_Based_Linearization.b;
    linsys(i).C = duffingNL_Timed_Based_Linearization.c;
    linsys(i).D = duffingNL_Timed_Based_Linearization.d;
end