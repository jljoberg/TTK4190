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
%% Model
hold on;
for i = 1:size(T_V,2);
  T = T_V(i);
  K = K_V(i);
  omega_b = .06;
  %T = 40;
  %K = -0.02;
  %omega_b = .03;
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
  
  %psi_V(:,i) = psi;
  %Plotting
  plot(t, psi*180/pi)
end
legend('1','2','3','4','5','6')

%Plotting
u = v(:,1);
% sim MSFartoystyring % The measurements from the simulink model are automatically written to the workspace.

