%% nonlinear model: Saturated vs. non-saturated
figure
subplot(2,1,1); hold on; 
plot(chi.time, chi.data(:,2), '--', 'Color', 'r'); plot(chi_sat.time, chi_sat.data(:,2), 'b');
legend('\chi_{non-saturated}', '\chi_{saturated}'); xlabel('Time [s]'); ylabel('Angle [deg]'); title('Course angle, nonlinear')
xlim([0,230])

subplot(2,1,2);hold on; 
plot(chi.time, chi.data(:,3),'--','Color','r'); plot(chi_sat.time, chi_sat.data(:,3),'b'); 
legend('\delta_{a_{non-sat}}','\delta_{a_{sat}}'); xlabel('Time [s]'); ylabel('Angle [deg]'); title('Aileron angle')
ylim([-30 30]); xlim([0,230])