%Given
clear; clc; close all;

t_max = 10000; %t_max=10000 for Magnetorquer and t_max=350 for reaction wheel

x0 = [0 0 0 1 1 2 3 0 0 0];


[t,y] = ode45(@attitude_model, [0 t_max], x0);

wx = y(:,5);
wy = y(:,6);
wz = y(:,7);

% Plot components
figure;
plot(t, wx, 'r', t, wy, 'g', t, wz, 'b');
xlabel('Time (s)');
ylabel('Angular velocity (rad/s)');
legend('wx','wy','wz');
title('Angular Velocity Components');
grid on;

% Magnitude
omega = sqrt(wx.^2 + wy.^2 + wz.^2);

figure;
plot(t, omega, 'b','LineWidth',1.5);
xlabel('Time (s)');
ylabel('|omega|');
title('Angular Velocity Magnitude');
grid on;




