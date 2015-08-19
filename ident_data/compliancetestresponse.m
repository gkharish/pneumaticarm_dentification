s = tf('s');

%pneumaticarm_sys = exp(-s*0.23)*K_gain*wn^2/(s^2 + 2*damping_ratio*wn*s + wn^2) - 0.09/2.2
pneumaticarm_sys = tf2%exp(-s*0.11)*K_gain*wn^2/(s^2 + 2*damping_ratio*wn*s + wn^2);
%plot(2*step(pneumaticarm_sys))


% for j = 1:1:300
% U(j) = -0.02;
% end
%xrange = 1000+1;
xlow = 4000;
xup = 6000;
% T= 0:0.01:(xrange-1)*0.01;
% for i = 1:1:xrange
%     if (i > xlow && i <= xup)                  % 928 && i <= 18370 for the file initpres2
%          U(i) = VarName6(i) - 0.535 ;           %U(i) = VarName6(i) - 0.545 ;
%     end
%     if(i <= xlow)
%          U(i) = 0;
%     end
%     if (i > xup)
%     U(i) =VarName6(i);
%     end
% end
inputdata = VarName6(xlow:xup) + VarName10(xlow:xup) - VarName6(xlow) -VarName10(xlow) ;
outputdata = VarName8(xlow:xup)  - VarName8(xlow);
U = inputdata ;
%% Idadat
%Ze = iddata(VarName8(1630:11630), U', 0.01);
figure(1)
%bode(Ze)
%% Simulate the system
ss_sys = ss(pneumaticarm_sys)
X0 = [ VarName8(2000);0;0];
T= 0:0.01:(xup -xlow)*0.01;
identifiedsysresponse = VarName8(xlow) + lsim(ss_sys, U, T); %VarName8(2000) + lsim(pneumaticarm_sys, U, T);
%y0 = lsim(pneumaticarm_sys, [0.2;2., [0;0.01]);
%igure(2)5000
%% Initial data ommited

% subplot (211), plot(VarName1(1630:11630)-VarName1(1630), identifiedsysresponse, 'r');
% hold on
% subplot(211), plot(VarName1(1630:11630)-VarName1(1630), VarName8(1630:11630), 'g');
% 
% subplot(212), plot(VarName1(1630:11630)-VarName1(1630), VarName6(1630:11630), 'g');
% hold on
% subplot(212), plot(VarName1(1630:11630)-VarName1(1630), U, 'r');
xrange_up =xup;
xrange_low =xlow;
subplot (211), plot(VarName1(xrange_low:xrange_up), identifiedsysresponse, 'r');
hold on
subplot(211), plot(VarName1(xrange_low:xrange_up), VarName8(xrange_low:xrange_up), 'g');

subplot(212), plot(VarName1(xrange_low:xrange_up), VarName6(xrange_low:xrange_up), 'g');
hold on
subplot(212), plot(VarName1(xrange_low:xrange_up), U, 'r');
%inputdataidentsinewave = U';
%outputdataidentsinewave = VarName8(1:xrange);