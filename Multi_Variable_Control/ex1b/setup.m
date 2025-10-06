%% double tank system
% sinusoidal
a = 0.2;        % [m^3/s]
omega = 5;      % [rad/s]
% step
qbar = 1.5;     % [m^3/s]
t_step = 0;

%simin signal
simin.time = [0:0.1:10]';
simin.signals.values = qbar + a * sin(omega * simin.time);

% simulate the system
model = sim("intro_1");
plot(model.simout);



%% Double tank system with two inputs and two outputs
qbar1 = 1.5;    % [m^3/s]
qbar2 = 0.5;    % [m^3/s]
a = 0.2;        % [m^3/s]
omega1 = 8;     % [rad/s]
omega2 = 5;     % [rad/s]
simin.time = [0:0.1:10]';
simin.signals.values = horzcat(qbar1 + a*sin(omega1*simin.time),...
    qbar2 + a*sin(omega2*simin.time));
% Simulate the system
model = sim("intro_2");
plot(model.simout)