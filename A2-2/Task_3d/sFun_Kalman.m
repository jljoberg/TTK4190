function [sys,x0,str,ts] = DiscKal(t,x,u,flag,data) % if method 2 is used

switch flag,

  case 0,
    [sys,x0,str,ts]= mdlInitializeSizes(data); %if method 2 is used

  case 3,
    sys= mdlOutputs(t,x,u,data); % if mathod 2 is used

  case 2,
    sys= mdlUpdate(t,x,u, data); % if method 2 is used
  
  case {1,4,}
    sys=[];

  case 9,
      sys=mdlTerminate(t,x,u);

  otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%   FUNCTIONS  %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%
function [sys,x0,str,ts]= mdlInitializeSizes(data); %if method 2 is used
disp('INIT');
% This is called only at the start of the simulation. 
sizes = simsizes; % do not modify

sizes.NumContStates  = 0;
sizes.NumDiscStates  = 5+5+5^2; 
sizes.NumOutputs     = 3;
sizes.NumInputs      = 2; 
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 1; % Do not modify  
sys = simsizes(sizes); % Do not modify  

%%% INITIAL STATES %%%
P0_ = data.P0_;
P0_V = P0_(:)';
x0_ = data.x0_;
x0_V = x0_(:)';
x0V = zeros(5,1)';

x0  = [x0_V, x0V, P0_V]; % Initial values for the discrete states, modify

str = []; % Do not modify
ts  = [-1 0]; % Sample time. [-1 0] means that sampling is
% inherited from the driving block and that it changes during
% minor steps.


function sys = mdlUpdate(t,x,u, data); % if method 2 is used

%%% NOTE:  u(1) -> compass   |  u(2) -> rudderInput
Ad = data.Ad;
Bd = data.Bd;
Cd = data.Cd;
%Ed = data.Ed;
Qd = data.Qd;
Rd = data.Rd;
%P0_ = data.P0_;
%x0_ = data.x0_;

x_ = x(1:5);
xHat = x(6:10);
P_V = x(11:35);
P_ = reshape(P_V, sqrt(length(P_V)), sqrt(length(P_V)) );

% Calculate the Kalman gain
L = P_*Cd'*(Cd*P_*Cd'+Rd)^-1;

% Update estimate with measurement
xHat = x_ + L*(u(1) - Cd*x_);

% Update error covariance matrix
I = eye(5);
P = (I-L*Cd)*P_*(I-L*Cd)' + L*Rd*L';

% Project ahead (Following {x_, P_} have timestep k+1)
x_ = Ad*xHat +Bd*u(2);
P_ = Ad*P*Ad' + Qd;
%%%%%%%%%%%%%%%%%%%%%%%%%
sys = [x_', xHat', P_(:)'];


function sys= mdlOutputs(t,x,u,data) % if mathod 2 is used
xHat = x(6:10)';
% Return [psi b]
sys=[xHat(2) xHat(3) xHat(5)];

function sys=mdlTerminate(t,x,u) 
sys = [];


