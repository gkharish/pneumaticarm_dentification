s = tf('s');

%pneumaticarm_sys = exp(-s*0.23)*K_gain*wn^2/(s^2 + 2*damping_ratio*wn*s + wn^2) - 0.09/2.2
pneumaticarm_sys = P3DU%exp(-s*0.11)*K_gain*wn^2/(s^2 + 2*damping_ratio*wn*s + wn^2);
%plot(2*step(pneumaticarm_sys))
T= 0:0.01:100;

% for j = 1:1:300
% U(j) = -0.02;
% end

for i = 1:1:10001
    if (i <=2138 && i >1402)
         U(i) =VarName6(i) - 0.30;
    end
    if(i<=1401)
         U(i) =0;
    end
    if (i>2138)
    U(i) =VarName6(i) - 0.2;
    end
end

%% Idadat
%Ze = iddata(VarName8(1630:11630), U', 0.01);
figure(1)
%bode(Ze)
%% Simulate the system
ss_sys = ss(pneumaticarm_sys);
X0 = [ -0.011;0;0];
identifiedsysresponse = lsim(ss_sys, U, T, X0);
%y0 = lsim(pneumaticarm_sys, [0.2;2.2], [0;0.01]);
%igure(2)
%% Initial data ommited

% subplot (211), plot(VarName1(1630:11630)-VarName1(1630), identifiedsysresponse, 'r');
% hold on
% subplot(211), plot(VarName1(1630:11630)-VarName1(1630), VarName8(1630:11630), 'g');
% 
% subplot(212), plot(VarName1(1630:11630)-VarName1(1630), VarName6(1630:11630), 'g');
% hold on
% subplot(212), plot(VarName1(1630:11630)-VarName1(1630), U, 'r');
subplot (211), plot(VarName1(1:10001), identifiedsysresponse, 'r');
hold on
subplot(211), plot(VarName1(1:10001), VarName8(1:10001), 'g');

subplot(212), plot(VarName1(1:10001), VarName6(1:10001), 'g');
hold on
subplot(212), plot(VarName1(1:10001), U, 'r');
inputdataidentsinewave = U';
outputdataidentsinewave = VarName8(1:10001);