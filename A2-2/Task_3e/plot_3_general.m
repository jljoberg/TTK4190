close all; should_print = 1; %#ok<*UNRCH>
%% Plot course
% Course noNoise vs. withNoise
figure
plot(sim_course.time, sim_course.data(:,1),sim_course.time, sim_course.data(:,2) ); grid on;
legend('\chi_{desired}', '\chi_{true}'); xlabel('Time [s]'); ylabel('Angle [deg]'); title('Course angle, measurement feedback')
xlim([0, 230]);

if should_print; print('3e_fig_course', '-depsc'); end 
%% Plot Aileron input
figure
plot(sim_delta_c.time, sim_delta_c.data(:,:)); grid on;
legend('\delta^c'); xlabel('Time [s]'); ylabel('Angle [deg]'); title('Aileron reference, measurement feedback')
xlim([0, 230]); ylim([-28 28]);

if should_print; print('3e_fig_aileron', '-depsc'); end 
%% Plot roll angle
figure
h_phi = plot(sim_phi.time, sim_phi.data(:,:)); grid on;
h_phi(1).LineWidth=2.2; h_phi(1).Color='r' ; h_phi(1).LineStyle='--';
h_phi(2).LineWidth=1 ; h_phi(2).Color='g' ; h_phi(3).LineStyle = ':';
legend('\phi_{clean}', '\phi_{estimate}','\phi_{measured}'); xlabel('Time [s]'); ylabel('Angle [deg]'); title('Roll angle, measurement feedback')
xlim([0, 230]);

if should_print; print('3e_fig_roll', '-depsc'); end
%% Plot roll rate
figure
h_p = plot(sim_p.time, sim_p.data(:,:)); grid on;
h_p(1).LineWidth=2.2; h_p(1).Color='r' ; h_p(1).LineStyle='--';
h_p(2).LineWidth=1 ; h_p(2).Color='g' ; h_p(3).LineStyle = ':';
legend('p_{clean}', 'p_{estimate}','p_{measured}'); xlabel('Time [s]'); ylabel('Angle rate [deg/s]'); title('Roll rate, measurement feedback')
xlim([0, 230]);

if should_print; print('3e_fig_roll_rate', '-depsc'); end
%% Plot yaw rate
figure; subplot(2,1,1);
h_r = plot(sim_r.time, sim_r.data(:,:)); grid on;
h_r(1).LineWidth=2.2; h_r(1).Color='r' ; h_r(1).LineStyle='--';
h_r(2).LineWidth=1 ; h_r(2).Color='g' ; h_r(3).LineStyle = ':';
legend('r_{clean}', 'r_{estimate}','r_{measured}'); xlabel('Time [s]'); ylabel('Angle rate [deg/s]'); title('Yaw rate, measurement feedback')
xlim([0, 230]);

subplot(2,1,2);
h_r_z = plot(sim_r.time, sim_r.data(:,:)); grid on;
h_r_z(1).LineWidth=2.2; h_r_z(1).Color='r' ; h_r_z(1).LineStyle='--'; h_r_z(2).LineWidth=1 ; h_r_z(2).Color=[0 1 0]*0.9 ;
h_r_z(3).LineStyle = ':'; h_r_z(3).LineWidth=2;
legend('r_{clean}', 'r_{estimate}','r_{measured}'); xlabel('Time [s]'); ylabel('Angle rate [deg/s]'); title('Yaw rate, measurement feedback, segment')
xlim([20, 40]);

if should_print; print('3e_fig_yaw_rate', '-depsc'); end