clear all; close all;
%%  Aircraft roll and course controller

%% State space definitions

% --- State SPACE -------------------------------------
A = [-0.322, 0.052, 0.028, -1.12 , 0.002; ...       %--
     0     , 0    , 1    , -0.001,     0; ...       %--
     -10.6 , 0    , -2.87, 0.46  , -0.65; ...       %--
     6.87  , 0    , -0.04, -0.32 , -0.02; ...       %--
     0     , 0    , 0    , 0     ,   -10 ];         %--
                                                    %--
B = [0 0 0 0 10]';                                  %--
                                                    %--
C = [0 0 0 1 0; ...                                 %--
     0 0 1 0 0; ...                                 %--
     1 0 0 0 0; ...                                 %--
     0 1 0 0 0];                                    %--
D = zeros(4,1);                                     %--
% -----------------------------------------------------

% --- State SPACE kalman version ----------------------
A_k = [-0.322, 0.052, 0.028, -1.12 ; ...            %--
     0     , 0    , 1    , -0.001; ...              %--
     -10.6 , 0    , -2.87, 0.46  ; ...              %--
     6.87  , 0    , -0.04, -0.32];                  %--
                                                    %--
B_k = [0.002, 0, -0.65, -0.2]';                     %--
                                                    %--
C_k = [0 1 0 0; ...                                 %--
     0 0 1 0; ...                                   %--
     0 0 0 1];                                      %--
D_k = zeros(3,1);                                   %--
E_k = [0 0 0 0]';                                    %--
% -----------------------------------------------------

% --- Discrete Kalman filter State space model --------                                     
Ts = 1/10;                                          %--
                                                    %--
[PHI,DELTA] = c2d(A_k,B_k,Ts);                      %-- 
[PHI,GAMMA] = c2d(A_k,E_k,Ts);                      %--
H = C_k;                                            %--
% -----------------------------------------------------

%% Constants

% Transformations
deg2rad = pi/180;
rad2deg = 180/pi;

% Aileron
a1 = 2.87;
a2 = -0.65;

g = 9.81; % [m/s^2] gravity
V_g = 637/3.6 ; % [m/s] Speed over ground (637 [km/h])  
d = 2; 


%% Controller design

% PID for phi
k_p_phi = -5/3; 
k_i_phi = 0;

% Calculating K_d_phi:
wp = sqrt(a2*k_p_phi);
zp = 1;
f_kd = @(zeta, wn) (2*zeta*wn - a1)/a2;
k_d_phi = f_kd(zp, wp);


% PI for course angle chi
Wx = 9;
wx = wp/Wx;
zx = 0.8;
k_p_chi = V_g/g * 2*zx*wx;
k_i_chi = V_g/g * wx^2; 

%% INITIALIZE data passed to S-function running Kalman
run init_Sfun_Kal.m

%% Run simulation and plot results
sim('sim_Aircraft_e.slx')
run plot_3_general.m

