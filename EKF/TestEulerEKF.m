%clear all

Nsamples = 500;
EulerSaved = zeros(Nsamples, 3);

dt = 0.02;

for k=1:Nsamples

  p = gyr_data(k, 1);
  q = gyr_data(k, 2);
  r = gyr_data(k, 3);

  ax = acc_data(k,1);
  ay = acc_data(k,2);
  [phi_a theta_a] = EulerAccel(ax, ay);
  
  [phi theta psi] = EulerEKF([phi_a theta_a]', [p q r], dt);
  
  EulerSaved(k, :) = [ phi theta psi ];
end

PhiSaved   = EulerSaved(:, 1) * 180/pi;
ThetaSaved = EulerSaved(:, 2) * 180/pi;
PsiSaved   = EulerSaved(:, 3) * 180/pi;


figure();
plot(t, PhiSaved, t, ThetaSaved)
title('Attitude from Kalman Filter');
legend('phi', 'theta');
xlabel('time(s)');
ylabel('attitude (deg)');
ylim([-90 90]);
grid on