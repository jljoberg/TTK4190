%% nonlinear model: Saturated vs. non-saturated
figure(1)
hold on; 
plot(chi.time, chi.data(:,2), '--', 'Color', 'r'); plot(chi_sat.time, chi_sat.data(:,2), 'b');
legend('\chi_{non-saturated}', '\chi_{saturated}'); xlabel('Time [s]'); ylabel('Angle [deg]'); title('Course angle, non linear')
xlim([0,230])