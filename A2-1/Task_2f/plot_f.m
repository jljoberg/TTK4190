%% Nonlinear: Course angle vs. course angle ref + aileron input
figure(1)
subplot(2,1,1); hold on;
plot(chi1.time, chi1.data(:,1), '--', 'Color', 'r'); plot(chi1.time, chi1.data(:,2), 'b');
legend('\chi^c', '\chi'); xlabel('Time [s]'); ylabel('Angle [deg]'); title('Course angle, nonlinear simulation')
xlim([0,230])

subplot(2,1,2)
plot(chi1.time, chi1.data(:,3))
legend('\delta_a^c'); xlabel('Time [s]'); ylabel('Angle [deg]'); title('Aileron angle reference')
ylim([-30 30]); xlim([0,230])

%% Linearized vs nonlinear model
figure(2)
subplot(2,1,1);hold on; 
plot(chi.time, chi.data(:,2), '--', 'Color', 'r'); plot(chi1.time, chi1.data(:,2), 'b');
legend('\chi_{linear}', '\chi_{nonlinear}'); xlabel('Time [s]'); ylabel('Angle [deg]'); title('Course angle, linear vs nonlinear')
xlim([0,230])

subplot(2,1,2); hold on;
plot(delta_a.time, delta_a.data(:,1), '--', 'Color', 'r'); plot(chi1.time, chi1.data(:,3), 'b');
legend('\chi_{linear}', '\chi_{nonlinear}'); xlabel('Time [s]'); ylabel('Angle [deg]'); title('Course angle, linear vs nonlinear')
xlim([0,230])
