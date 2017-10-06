clear all; close all;
%%  Aircraft roll and course controller

%% Constants

% Transformations
deg2rad = pi/180;
rad2deg = 180/pi;

% Aileron
a1 = 2.87;
a2 = -0.65;

% PID for phi
k_p_phi = -5/3; 
k_i_phi = 0; % Change later!

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

%% Define transfer function

s = tf('s');
H = tf( a2/( s *(s^2 + (a1+a2*k_d_phi)*s + a2*k_p_phi ) ) );
k = -2:0.01:6;
rlocus(-H,k); xlim([-1 0.5])

%% Bode using different k_i_phi

k_i_tmp = [0; -0.5; -1; -1.5];

for i =1:size(k_i_tmp,1)
    sys(i) = tf( a2*k_p_phi*(s+k_i_tmp(i)/k_p_phi) / ( s^3  + s^2*(a1+a2*k_d_phi) + s*(a2*k_p_phi) + a2*k_i_tmp(i) )  );
end

figure;
bode(sys(1), sys(2), sys(3), sys(4)); grid on
legend('k_i_phi=0','k_i_phi=-0.5','k_i_phi=-1','k_i_phi=-1.5')