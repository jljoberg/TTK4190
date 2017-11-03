
tstart=0;           % Sim start time
tstop=10000;        % Sim stop time
tsamp=10;           % Sampling time for how often states are stored. (NOT ODE solver time step)
                
p0=zeros(2,1);      % Initial position (NED)
v0=[0.1 0]';       % Initial velocity (body)
psi0=0;             % Inital yaw angle
r0=0;               % Inital yaw rate
c=0;                % Current on (1)/off (0)


nc_V   = 0.5:0.5:8.5;
u_ss = zeros(size(nc_V));

for i = 1:size(nc_V,2)
    nc = nc_V(i);
    sim MsFartoystyring
    u_ss(i) = mean(v(800:1000,1));    
end

%% forhold

tmp = nc_V./u_ss;
stem(tmp);
