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
% close all
clear all; close all; 
%% Heading Model
% T_psi = 40;
% K_psi = -0.02;
% omega_b_psi = .03;
T_psi = 100;
K_psi = -0.05;
omega_b_psi = .06;zeta_psi = 1;
omega_n_psi = omega_b_psi/(sqrt(1-2*zeta_psi^2+sqrt(4*zeta_psi^4-4*zeta_psi^2+2)));
K_m_psi = 0;
m_psi=T_psi/K_psi;
k_psi=0;
d_psi=1/K_psi;
K_p = (m_psi+K_m_psi)*omega_n_psi^2-k_psi; %-18; %-40
K_d = -(2*zeta_psi*omega_n_psi*(m_psi+K_m_psi)-d_psi); %=350;%= 350; %1/40
K_i = K_p*omega_n_psi/10;%-1/100; %-1/100

%% Surge Model
T_u = 200;
K_u = 0.8157;
omega_b_u = .7;
zeta_u = 1;
omega_n_u = omega_b_u/(sqrt(1-2*zeta_u^2+sqrt(4*zeta_u^4-4*zeta_u^2+2)));
K_m_u = 0;
m_u = T_u/K_u;
k_u = 0;
d_u = 1/K_u;
K_p_u = -(m_u+K_m_u)*omega_n_u^2-k_u; %-100
K_d_u = 2*zeta_u*omega_n_u*(m_u+K_m_u)-d_u; %10
K_i_u = K_p_u*omega_n_u/10;


%%
tstart=0;           % Sim start time
tstop=4000;        % Sim stop time
tsamp=10;           % Sampling time for how often states are stored. (NOT ODE solver time step)
                
p0=zeros(2,1);      % Initial position (NED)
v0=[4 0]';       % Initial velocity (body)
psi0=0;             % Inital yaw angle
r0=0;               % Inital yaw rate
c=0;                % Current on (1)/off (0)

modelName = 'Sim1_8';
sim(strcat(modelName, '.slx'));

dc = rad2deg(dc);
max_rudder = 25;
for i = 1:length(dc)
    if(dc(i) > max_rudder)
        dc(i) =max_rudder;
    elseif(dc(i) < -max_rudder)
        dc(i) = -max_rudder;
    end
end

n_max = 85*2*pi/60;
for i = 1:length(nc)
    if(nc(i) > n_max)
        nc(i) =n_max;
    elseif(nc(i) < -n_max)
        nc(i) = -n_max;
    end
end
nc = rad2deg(nc);
Plotting
u = v(:,1);
% sim MSFartoystyring % The measurements from the simulink model are automatically written to the workspace.

