function [sys,x0,str,ts] = sFun_Kalman(t,x,u,flag,data) % if method 2 is used
% ============ CHECK SCENARIO, CALL FUNC ==================================
switch flag

  case 0
    [sys,x0,str,ts]= mdlInitializeSizes(data); %if method 2 is used

  case 3
    sys= mdlOutputs(t,x,u,data); % if mathod 2 is used

  case 2
    sys= mdlUpdate(t,x,u, data); % if method 2 is used
  
  case {1,4,}
    sys=[];

  case 9
      sys=mdlTerminate(t,x,u);

  otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end

% =========================================================================

% ============ FUNCTIONS ==================================================

function [sys,x0,str,ts]= mdlInitializeSizes(data) %if method 2 is used
disp('INIT');
% This is called only at the start of the simulation. 
sizes = simsizes; % do not modify

sizes.NumContStates  = 0;
sizes.NumDiscStates  = 4+4+4^2; 
sizes.NumOutputs     = 4;
sizes.NumInputs      = 4; 
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 1; % Do not modify  
sys = simsizes(sizes); % Do not modify  

%%% INITIAL STATES %%%
P0_ = data.P0_;
P0_V = P0_(:)';
x0_ = data.x0_;
x0_V = x0_(:)';
x0V = zeros(4,1)';

x0  = [x0_V, x0V, P0_V]; % Initial values for the discrete states, modify


str = []; % Do not modify
ts  = [-1 0]; % Sample time. [-1 0] means that sampling is
% inherited from the driving block and that it changes during
% minor steps.

function sys = mdlUpdate(t,x,u, data) % if method 2 is used

% ============ ACESSING DATA FROM STRUCT ==================================
PHI = data.Ad;
DELTA = data.Bd;
H = data.Cd;
%GAMMA = data.Ed;
Qd = data.Qd;
Rd = data.Rd;
%P0_ = data.P0_;
%x0_ = data.x0_;

% ============ UNPACK SYSTEM VARS =========================================
x_ = x(1:4);
GAMMA = eye(4);
xHat = x(5:8); %#ok<NASGU>
P_V = x(9:24);
P_ = reshape(P_V, sqrt(length(P_V)), sqrt(length(P_V)) );

% =========================================================================
% ============ KALMAN EQUATIONS ===========================================
                                                                        %==
% Calculate the Kalman gain                                             %==
L = P_*H'*(H*P_*H'+Rd)^-1;                                              %==
                                                                        %==
% Update estimate with measurement                                      %==
xHat = x_ + L*(u(2:4) - H*x_);                                          %==
                                                                        %==
% Update error covariance matrix                                        %==
I = eye(4);                                                             %==
P = (I-L*H)*P_*(I-L*H)' + L*Rd*L';                                      %==
                                                                        %==
% Project ahead (Following {x_, P_} have timestep k+1)                  %==
x_ = PHI*xHat +DELTA*u(1);                                              %==
P_ = PHI*P*PHI' +GAMMA*Qd*GAMMA';                                       %==
                                                                        %==
% =========================================================================
% =========================================================================
sys = [x_', xHat', P_(:)'];


function sys= mdlOutputs(t,x,u,data) %#ok<*INUSL,*INUSD>
x_ = x(1:4)'; % sFunc output lags one time-step => output prediction
sys = x_;

function sys=mdlTerminate(t,x,u) 
sys = [];


