% Simple program to estimate the 2nd order system using step response data 



pic1 = 1.09;
pic2 = 0.9315;
steady_state = 0.8969;
deltaT = 0.85;
step_input =2;

wd = 2*pi/deltaT;

overshoot = (pic1 - steady_state)/steady_state;

damping_ratio = sqrt( log(overshoot)^2/( (log(overshoot))^2 + pi^2) );
%damping_ratio = 0.4
wn = wd/sqrt(1- damping_ratio^2);
wn = 7.8;
K_gain = steady_state/step_input;

s = tf('s');

%pneumaticarm_sys = exp(-s*0.23)*K_gain*wn^2/(s^2 + 2*damping_ratio*wn*s + wn^2) - 0.09/2.2
pneumaticarm_sys = P3DU%exp(-s*0.11)*K_gain*wn^2/(s^2 + 2*damping_ratio*wn*s + wn^2)
%plot(2*step(pneumaticarm_sys))
T= 0:0.01:101;

for j = 1:1:100
U(j) = -0.1;
end

for i = 101:1:10101
    U(i) =2;
end
%% Idadat
%Ze = iddata(VarName8(1630:11630), U', 0.01);
figure(1)
%bode(Ze)
%% Simulate the system
ss_sys = ss(pneumaticarm_sys);
X0 = [ -0.046;0];
identifiedsysresponse = lsim(ss_sys, U, T, X0);
y0 = lsim(pneumaticarm_sys, [0.2;2.2], [0;0.01]);
figure(2)
%% Initial data ommited

% subplot (211), plot(VarName1(1630:11630)-VarName1(1630), identifiedsysresponse, 'r');
% hold on
% subplot(211), plot(VarName1(1630:11630)-VarName1(1630), VarName8(1630:11630), 'g');
% 
% subplot(212), plot(VarName1(1630:11630)-VarName1(1630), VarName6(1630:11630), 'g');
% hold on
% subplot(212), plot(VarName1(1630:11630)-VarName1(1630), U, 'r');
%% Entire data set
subplot (211), plot(VarName1(1530:11630)-VarName1(1530), identifiedsysresponse, 'r');
hold on
subplot(211), plot(VarName1(1530:11630)-VarName1(1530), VarName8(1530:11630), 'g');

subplot(212), plot(VarName1(1530:11630)-VarName1(1530), VarName6(1530:11630), 'g');
hold on
subplot(212), plot(VarName1(1530:11630)-VarName1(1530), U, 'r');

for cnt1 = 1:1:100
    inputdataident(cnt1) = -0.1;
end
for cnt2 = 101:1:401
    inputdataident(cnt2) = 2;
end
inputdataident = inputdataident';
outputdataident = VarName8(1530:1930);
%figure(3)
%bode(ss_sys)
%% Impulse response
% Ze = iddata(VarName8(1630:11630));
%sys_impulse = impulseest(Ze, 60);
%h = impulseplot(sys_impulse);
%% System Identification toolbox
% Ze = iddata(VarName8(1630:11630), VarName6(1630:11630), 0.01);
% Ze1 = Ze(1:5000);
% Zv1 = Ze(5001:10001);
% Ge = spa(Ze);
% bode(Ge);
% 
% modelimp = impulseest(Ze1,2500);
% step(modelimp);