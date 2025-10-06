function dx = duffing_func(u,l,alpha,m,k,g)
x1 = u(1);
x2 = u(2);
uin = u(3);
dx(1) = x2;
dx(2) = g/l*sin(x1) - alpha/(m*l^2)*x1 - k/(m*l^2)*x2 + uin;
end
