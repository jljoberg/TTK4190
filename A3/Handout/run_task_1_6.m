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


%%
tstart=0;           % Sim start time
tstop=30000;        % Sim stop time
tsamp=10;           % Sampling time for how often states are stored. (NOT ODE solver time step)
                
p0=zeros(2,1);      % Initial position (NED)
v0=[0.01 0]';       % Initial velocity (body)
psi0=0;             % Inital yaw angle
r0=0;               % Inital yaw rate
c=0;                % Current on (1)/off (0)

n_start = 3;
n_end = 8;
N = n_end - n_start;

u_ss = zeros(N + 1,1);  % Steady state value at ncommand = index + n_start - 2
K = zeros(N,1);     % K = 1/m
T = zeros(N,1);     % T = m/d at ncommand = index + n_start - 1

ncommand = n_start-1;

modelName = 'Sim1_6';
sim(strcat(modelName, '.slx')); 
    
u = v(:,1);
u_ss(1) = u(length(u));

for ncommand = n_start:n_end      % Shaft speed (rad/s)
    u_ss_index = ncommand - n_start + 2;
    parameter_index = ncommand - n_start + 1;
    v0 = [0.01,0]';
    
    modelName = 'Sim1_6';
    sim(strcat(modelName, '.slx')); 
    
    u = v(:,1);
    u_ss(u_ss_index) = u(length(u));
    
    v0 = [u_ss(u_ss_index),0]';
    
    modelName = 'Sim1_6';
    sim(strcat(modelName, '.slx')); 

    u = v(:,1);

    % % nonlinear least-squares parametrization: T dr/dt + r = K delta,   delta = -delta_R
    % % x(1) = 1/T and x(2) = K
    x0 = [u_ss(u_ss_index-1), u_ss(u_ss_index), 1];
    lb = [u_ss(u_ss_index-1), u_ss(u_ss_index), -inf];     % Restrict K_tau to last (steady state) value of u
    ub = [u_ss(u_ss_index-1), u_ss(u_ss_index), inf];      % Restrict K_tau to last (steady state) value of u
    F = inline('x(1) + x(2)*(1-exp(-t*x(3)))', 'x', 't');
    x = lsqcurvefit(F, x0, t, u, lb, ub);

    K(parameter_index) = x(2);
    T(parameter_index) = 1/x(3);

%     figure();
%     plot(t, u); hold on; plot(t, F(x, t)); legend('Surge speed', 'Modelled surge speed');
end

ncommands = n_start:n_end;
K = K./ncommands';

figure();
stem(K);
figure();
stem(T);
% Plotting
% sim MSFartoystyring % The measurements from the simulink model are automatically written to the workspace.

 