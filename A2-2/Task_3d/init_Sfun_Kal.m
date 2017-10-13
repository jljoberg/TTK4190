var_phi = (2*deg2rad)^2;
var_p   = (0.5*deg2rad)^2;
var_r   = (0.2*deg2rad)^2;
R = diag([var_phi var_p var_r]);

Q = 1e-6*diag([1 1 1 1]);

P0_ = 1e-6*diag([1 1 1 1]);
x0_ = [0 0 0 0];

data = struct( 'Ad',PHI,  'Bd',DELTA ,  'Cd',H ,  'Ed',GAMMA ,  'Qd',Q ,  'Rd',R ,  'P0_',P0_ , 'x0_',x0_ );