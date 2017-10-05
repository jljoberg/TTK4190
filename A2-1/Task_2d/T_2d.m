close all;
s = tf('s');
%% Constants

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


%% Derived feedback system for roll and course
phi_CL = tf( a2*k_p_phi*(s+k_i_phi/k_p_phi)  /  ( s^3  + s^2*(a1+a2*k_d_phi) + s*(a2*k_p_phi) + a2*k_i_phi )  );

chi_H = g/V_g * 1/s * phi_CL * (k_i_chi/s + k_p_chi) ; % note: not canonical
chi_CL = minreal(chi_H/(1+chi_H));



%% OPEN LOOP PHI
phi_OL = a2*k_p_phi/(s^2 + s*(a1 + a2*k_d_phi));

phi_fb = phi_OL/(1+phi_OL); % note: not canonical
phi_FB = minreal(phi_fb); % Should be equal to phi_CL if done correctly


%% OPEN LOOP CHI

chi_OL = g/V_g * (a2*k_p_phi*(k_i_chi + s*k_p_chi)) / (  s^4 + s^3*(a1+a2*k_d_phi) + s^2*(a2*k_p_phi) );

chi_fb = chi_OL/(1+chi_OL);
chi_FB = minreal(chi_fb);

%% Comare BODE plot

% subplot(1,2,2)
bode(phi_OL, chi_OL); grid on;
legend('\phi/\phi^c open loop', '\chi/\chi^c open loop')
title('Open loop, W_\chi = 9, \zeta_\chi = 0.8')

% subplot(1,2,2)
% figure;
% bode(phi_CL, chi_CL); grid on;
% legend('\phi/\phi^c closed loop', '\chi closed loop')






