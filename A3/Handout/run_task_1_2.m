clear all;
clc;

tstart=0;           % Sim start time
tstop=10000;        % Sim stop time
tsamp=10;           % Sampling time for how often states are stored. (NOT ODE solver time step)
                
p0=zeros(2,1);      % Initial position (NED)
v0=[4.9 0]';       % Initial velocity (body)
psi0=0;             % Inital yaw angle
r0=0;               % Inital yaw rate
c=0;                % Current on (1)/off (0)

%%
deg2rad = pi/180;
rad2deg = 1/deg2rad;

dc_V = (5:0.2:6) * deg2rad;% dc_V(1) = 6*deg2rad;
r_V  = zeros(size(dc_V));
K    = zeros(size(dc_V));
T    = zeros(size(dc_V));

F = @(x, xdata) x(1)*(1 - exp(-xdata/x(2)) );
x0 = [-0.1; 20];

for i =1:size(dc_V,2)
    dc = dc_V(i);
    sim MSFartoystyring_ssavg
    r_V(i) = r(end);
    
    tmp = lsqcurvefit(F, x0, t, r);
    x0 = tmp;
    
    rV(i,:) = r;
    K(i) = tmp(1)/dc;
    T(i) = tmp(2);
end

rudder = ones(size(rV(:,:))) .* dc_V(:);
%plot(rad2deg*dc_V, rad2deg*r_V); ylabel('r_{ss}'); xlabel('\delta_c')

%% Plot
close all
for i=1:size(T,2)
    figure; hold on
    plot(t,rV(i,:)); plot(t, F([dc_V(i)*K(2),T(2)],t))
    xlim([0 1000]);
    legend('Heading', 'Curve fitted heading');
end