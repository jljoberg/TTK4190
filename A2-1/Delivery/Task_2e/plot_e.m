%% Linear: Course angle vs. course angle ref + aileron input
subplot(2,1,1); hold on;
plot(chi.time, chi.data(:,1), '--', 'Color', 'r'); plot(chi.time, chi.data(:,2), 'b');
legend('\chi^c', '\chi'); xlabel('Time [s]'); ylabel('Angle [deg]'); title('Course angle, linear')
xlim([0,230])

subplot(2,1,2)
plot(delta_a.time, delta_a.data(:,1))
legend('\delta_a'); xlabel('Time [s]'); ylabel('Angle [deg]'); title('Aileron angle')
ylim([-30 30]); xlim([0,230])