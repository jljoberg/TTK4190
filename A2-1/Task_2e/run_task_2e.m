clear all; close all;
%%  Aircraft roll and course controller

%% Constants

% Transformations
deg2rad = pi/180;
rad2deg = 180/pi;

% Aileron
a1 = 2.87;
a2 = -0.65;

%% Controller design

% PID for phi
k_p_phi = -5/3; 
k_i_phi = 0;

% Calculating K_d_phi:
wp = sqrt(a2*k_p_phi);
zp = 0.7;
f_kd = @(zeta, wn) (2*zeta*wn - a1)/a2;
k_d_phi = f_kd(zp, wp);

g = 9.81; % [m/s^2] gravity
V_g = 637/3.6 ; % [m/s] Speed of ground (637 [km/h])  
d = 2; 

% PI for course angle chi
Wx = 9;
wx = wp/Wx;
zx = 0.8;
k_p_chi = V_g/g * 2*zx*wx;
k_i_chi = V_g/g * wx^2; 

%% Run simulation and plot results
sim('BlockDprob2e.slx');
run plot_e.m

%print('plot_T2_e', '-depsc')
