% File: pendulum_func.m
function dx = pendulum_func(u,b,g)
uin = u(1);
theta = u(2);
omega = u(3);
dx(1) = omega;
dx(2) = -b*omega - g*sin(theta) + uin;
end



