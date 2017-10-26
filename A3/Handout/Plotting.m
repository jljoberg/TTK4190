figure()
plot(p(:,1), p(:,2))
title({strrep(modelName, '_', ' '), 'Trajectory'});

figure()
title({strrep(modelName, '_', ' '), '\Psi, r and \delta_c'});
subplot(3, 1, 1)
plot(t, psi); hold on; plot(t, -3*sin(0.008*t)); plot(t, psi+3*sin(0.008*t))
legend('\psi', '\psi_d', 'psi error')
subplot(3, 1, 2)
plot(t, r); hold on; plot(t, -3*0.008*cos(0.008*t)); plot(t, psi+-3*0.008*cos(0.008*t))
legend('r', 'r_d', 'r error')
subplot(3, 1, 3)
