figure()
plot(p(:,1), p(:,2))
title({strrep(modelName, '_', ' '), 'Trajectory'});

figure()
title({strrep(modelName, '_', ' '), '\Psi, r and \delta_c'});
subplot(3, 1, 1)
plot(t, rad2deg(psi)); hold on; plot(t, rad2deg(psi_d)); plot(t, rad2deg(psi-psi_d))
legend('\psi', '\psi_d', '\psi error'); ylabel('Heading Angle (deg)')
subplot(3, 1, 2)
plot(t, r); hold on; plot(t, -3*0.008*cos(0.008*t)); plot(t, r+3*0.008*cos(0.008*t))
legend('r', 'r_d', 'r error'); ylabel('Surge Velocity (m/s)')
subplot(3, 1, 3)
plot(t, dc)
xlabel('Time (sec)'); ylabel('Rudder input (deg)')

figure()
v_total = (v(:,1).^2 + v(:,2).^2).^.5;
plot(t, v(:,1)); hold on; plot(t, v(:,2)); plot(t, v_total)
legend('u', 'v', 'total velocity')

% figure()
% plot(t, norm()v(:,1)); hold on; plot(t, v(:,2))
% legend('x dot', 'y dot')
