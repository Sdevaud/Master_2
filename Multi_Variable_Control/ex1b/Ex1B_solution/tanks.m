%% Double tank system
% Sinusoidal
a = 0.2;        % [m^3/s]
omega = 5;      % [rad/s]
% Step
qbar = 1.5;     % [m^3/s]
t_step = 0;
% Simin signal
simin.time = [0:0.1:10]';
simin.signals.values = qbar + a*sin(omega*simin.time);
% Simulate the system
model = sim("tanks");
plot(model.simout)

%% Double tank system with two inputs and two outputs
qbar1 = 1.5;    % [m^3/s]
qbar2 = 0.5;    % [m^3/s]
a = 0.2;        % [m^3/s]
omega1 = 8;     % [rad/s]
omega2 = 5;     % [rad/s]
simin2.time = [0:0.1:10]';
simin2.signals.values = horzcat(qbar1 + a*sin(omega1*simin2.time),...
    qbar2 + a*sin(omega2*simin2.time));
% Simulate the system
model = sim("tanks2");
plot(model.simout2)

