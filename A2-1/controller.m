%%  Aircraft roll and course controller

%% Constants

a1 = 2.87;
a2 = -0.65;

kp = -5/3;
w = sqrt(a2*kp);
z = 0.7;

f_kd = @(zeta, wn) (2*zeta*wn - a1)/a2;

kd = f_kd(z, w);

%% Define transfer function

s = tf('s');
H = tf( -a2/( s *(s^2 + (a1+a2*kd)*s + a2*kp ) ) );
rlocus(H);

%% Choose ki and find poles
ki = -0.0; %Change later
sys = tf( a2*kp*(s+ki/kp)  /  ( s^3  + s^2*(a1+a2*kd) + s*(a2*kp) + a2*ki )  );
pole(sys)
bode(sys); grid on;

%% Bode using different ki

ki = [0; -0.5; -1; -1.5];

for i =1:size(ki,1)
    sys(i) = tf( a2*kp*(s+ki(i)/kp) / ( s^3  + s^2*(a1+a2*kd) + s*(a2*kp) + a2*ki(i) )  );
end

bode(sys(1), sys(2), sys(3), sys(4)); grid on
legend('ki=0','ki=-0.5','ki=-1','ki=-1.5')

