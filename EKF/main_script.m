csvread('steady_data.csv');

t = ans(:,1)-ans(1,1);
acc_data = ans(:,2:4);
gyr_data = deg2rad(ans(:,5:7));

acc_bias = mean(acc_data,1);
gyr_bias = mean(gyr_data,1);

acc_data = acc_data - acc_bias;
gyr_data = gyr_data - gyr_bias;

g = 9.8;

theta_acc = asin(  acc_data(:,1) / g );
phi_acc   = asin( -acc_data(:,2) ./ (g*cos(theta_acc)) );

figure();
plot(t,phi_acc, t, theta_acc);
title('Attitude from accelerometer data');
legend('phi','theta');
xlabel('time(s)');
ylabel('attitude (deg)');
ylim([-90 90]);
grid on

figure();
plot(t,acc_data(:,1), t, acc_data(:,2));
title('Accelerometer data');
legend('phi','theta');
xlabel('time(s)');
ylabel('acceleration (m/s^2)');
ylim([-10 10]);
grid on

figure();
plot(t,rad2deg(gyr_data(:,1)), t, rad2deg(gyr_data(:,2)), t, rad2deg(gyr_data(:,3)));
title('Gyroscope data');
legend('Axis 1','Axis 2', 'Axis 3');
xlabel('time(s)');
ylabel('Angle rate (deg/s)');
ylim([-90 90]);
grid on

TestEulerEKF

csvread('data.csv');

t = ans(:,1)-ans(1,1);
acc_data = ans(:,2:4);
gyr_data = deg2rad(ans(:,5:7));

acc_data = acc_data - acc_bias;
gyr_data = gyr_data - gyr_bias;

g = 9.8;

theta_acc = asin(  acc_data(:,1) / g );
phi_acc   = asin( -acc_data(:,2) ./ (g*cos(theta_acc)) );

figure();
plot(t,rad2deg(phi_acc), t, rad2deg(theta_acc));
title('Attitude from accelerometer data');
legend('phi','theta');
xlabel('time(s)');
ylabel('attitude (deg)');
ylim([-90 90]);
grid on

figure();
plot(t,acc_data(:,1), t, acc_data(:,2));
title('Accelerometer data');
legend('x','y');
xlabel('time(s)');
ylabel('acceleration (m/s^2)');
ylim([-10 10]);
grid on

figure();
plot(t,rad2deg(gyr_data(:,1)), t, rad2deg(gyr_data(:,2)), t, rad2deg(gyr_data(:,3)));
title('Gyroscope data');
legend('Axis 1','Axis 2', 'Axis 3');
xlabel('time(s)');
ylabel('Angle rate (deg/s)');
ylim([-90 90]);
grid on

TestEulerEKF