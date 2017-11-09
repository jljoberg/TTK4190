%% Information 
% This file is only an example of how you can start the simulation. The
% sampling time decides how often you store states. The execution  time
% will increase if you reduce the sampling time.

% Please note that the file "pathplotter.m" (only used in the second part
% of the assignment) shows the ship path during the path following and
% target tracking part of the assignment. It can be clever to adjust the sampling
% time when you use that file because it draws a sketch of the ship in the
% North-East plane at each time instant. Having a small sampling time will
% lead to a lot over overlap in the ship drawing. 

% You should base all of your simulink models on the MSFartoystyring model
% and extend that as you solve the assignment. For your own sake, it is
% wise to create a new model and run file for each task. That is
% especially important in the problems you need to hand in since the files
% you deliver only should create the desired result in that task.

% The msfartoystyring.m file includes the ship model. You are not allowed
% to change anything within that file. You need to include that file in
% every folder where you have a simulink model based on
% "MSFartoystyring.slx". 

% WP.mat is a set of six waypoints that you need to use in the second part of
% the assignment. The north position is given in the first row and the east
% position in the second row. 
close all
clear all
run_r_ss_avg
T_V = T; K_V = K;

%%
tstart=0;           % Sim start time
tstop=20000;        % Sim stop time
tsamp=10;           % Sampling time for how often states are stored. (NOT ODE solver time step)
                
p0=zeros(2,1);      % Initial position (NED)
v0=[6.63 0]';       % Initial velocity (body)
psi0=0;             % Inital yaw angle
r0=0;               % Inital yaw rate
c=1;                % Current on (1)/off (0)
%% Test different K and T
close; figure; hold on; title('Compare K,T sets, given \omega_b=0.06');
for i = 1:size(T_V,2);
  T = T_V(i);
  K = K_V(i);
  omega_b = .06;

  zeta = 1;
  omega_n = omega_b/(sqrt(1-2*zeta^2+sqrt(4*zeta^4-4*zeta^2+2)));
  K_m = 0;
  m=T/K;
  k=0;
  d=1/K;
  K_p = (m+K_m)*omega_n^2-k; %=-18;%-18;
  K_d = 2*zeta*omega_n*(m+K_m)-d; %=350;%
  K_d = -K_d;
  K_i = 0*K_p*omega_n/10;

  modelName = 'Sim1_3';
  sim(strcat(modelName, '.slx'));
 
  plot(t, psi*rad2deg)
end
inputStepLegendCell = cellstr(num2str([dc_V'*rad2deg , K_V' , T_V'], 'delta_c = %g, K = %g, T = %g'));
legend(inputStepLegendCell);


%% Test different omega_b, given best T,K
figure; hold on; title('Compare \omega_b, given T/K set 1')
for i = 6:8;
  T = T_V(1);
  K = K_V(1);
  omega_b = 0.01*i;

  zeta = 1;
  omega_n = omega_b/(sqrt(1-2*zeta^2+sqrt(4*zeta^4-4*zeta^2+2)));
  K_m = 0;
  m=T/K;
  k=0;
  d=1/K;
  K_p = (m+K_m)*omega_n^2-k; %=-18;%-18;
  K_d = 2*zeta*omega_n*(m+K_m)-d; %=350;%
  K_d = -K_d;
  K_i = 0*K_p*omega_n/10;

  modelName = 'Sim1_3';
  sim(strcat(modelName, '.slx'));
  
  plot(t, psi*180/pi)
end
bandwidthLegendCell = cellstr(num2str((1:8)'.*0.01, 'omega_b = %g'));
legend(bandwidthLegendCell);
