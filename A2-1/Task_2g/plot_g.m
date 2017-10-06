%% nonlinear model: Saturated vs. non-saturated
subplot(2,1,1)
plot(chi.time, chi.data(:,2), '--', 'Color', 'r'); plot(chi_sat.time, chi_sat.data(:,2), 'b');
legend('\chi_{non-saturated}', '\chi_{saturated}'); xlabel('Time [s]'); ylabel('Angle [deg]'); title('Course angle, non linear')
xlim([0,230])

subplot(2,1,2)
plot(chi.time, chi.data(:,3)); plot(chi_sat.time, chi_sat.data(:,3),'b'); 
legend('\delta_a','\delta_a_sat'); xlabel('Time [s]'); ylabel('Angle [deg]'); title('Aileron angle')
ylim([-30 30]); xlim([0,230])