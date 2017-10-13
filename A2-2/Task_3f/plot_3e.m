%% nonlinear model: Saturated vs. non-saturated

% Course noNoise vs. withNoise
figure
plot(chi.time,chi.data(:,1), chi.time, chi.data(:,2),noise.time, noise.data(:,2),noise.time,noise.data(:,3)); grid on;
legend('\chi_{desired}', '\chi_{no noise}', '\chi_{noise}', '\chi_{estimate}'); xlabel('Time [s]'); ylabel('Angle [deg]'); title('Course angle, nonlinear')
xlim([0, 230]);

