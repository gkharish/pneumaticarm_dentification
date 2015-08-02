s = tf('s');

%pneumaticarm_sys = exp(-s*0.23)*K_gain*wn^2/(s^2 + 2*damping_ratio*wn*s + wn^2) - 0.09/2.2
pneumaticarm_sys = P3DU%exp(-s*0.11)*K_gain*wn^2/(s^2 + 2*damping_ratio*wn*s + wn^2);
%plot(2*step(pneumaticarm_sys))
T= 0:0.01:101;

for j = 1:1:100
U(j) = -0.05;
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
X0 = [ -0.046;0;0];
identifiedsysresponse = lsim(ss_sys, U, T, X0);
%y0 = lsim(pneumaticarm_sys, [0.2;2.2], [0;0.01]);
figure(2)
%% Initial data ommited

% subplot (211), plot(VarName1(1630:11630)-VarName1(1630), identifiedsysresponse, 'r');
% hold on
% subplot(211), plot(VarName1(1630:11630)-VarName1(1630), VarName8(1630:11630), 'g');
% 
% subplot(212), plot(VarName1(1630:11630)-VarName1(1630), VarName6(1630:11630), 'g');
% hold on
% subplot(212), plot(VarName1(1630:11630)-VarName1(1630), U, 'r');
subplot (211), plot(VarName1(1530:11630)-VarName1(1530), identifiedsysresponse, 'r');
hold on
subplot(211), plot(VarName1(1530:11630)-VarName1(1530), VarName8(1530:11630), 'g');

subplot(212), plot(VarName1(1530:11630)-VarName1(1530), VarName6(1530:11630), 'g');
hold on
subplot(212), plot(VarName1(1530:11630)-VarName1(1530), U, 'r');
