figure()
plot(p(:,1), p(:,2))
title({strrep(modelName, '_', ' '), 'Trajectory'});

figure()
subplot(3, 1, 1)
plot(t, rad2deg(psi)); hold on; plot(t, rad2deg(psi_d)); plot(t, rad2deg(psi-psi_d))
legend('\psi', '\psi_d', '\psi error'); ylabel('Heading Angle (deg)')
title({strrep(modelName, '_', ' '), '\Psi, r and \delta_c'});
subplot(3, 1, 2)
plot(t, r); hold on; plot(t, r_d); plot(t, r-r_d)
legend('r', 'r_d', 'r error'); ylabel('Heading Velocity (deg/s)')
subplot(3, 1, 3)
plot(t, dc); hold on; plot(t, max_rudder*ones(size(t)), '-r'); plot(t, -max_rudder*ones(size(t)), '-r')
legend('\delta_c', 'saturation')
xlabel('Time (sec)'); ylabel('Rudder input (deg)')

if exist('ud', 'var')
    figure()
    subplot(2, 1, 1)
    plot(t, v(:,1)); hold on; plot(t, ud); plot(t, v(:,1)-ud)
    title({strrep(modelName, '_', ' '), 'u and n_c'});
    legend('u', 'u_d', 'u error'); ylabel('Surge speed (m/s)')
    subplot(2, 1, 2)
    plot(t, nc); hold on; plot(t, rad2deg(n_max)*ones(size(t)), '-r'); plot(t, -rad2deg(n_max)*ones(size(t)), '-r')
    legend('n_c', 'saturation')
    ylabel('Shaft Velocity (deg/sec)'); xlabel('Time (sec)')
end

