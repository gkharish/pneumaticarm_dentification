%% Program to identify  and simulate the identified transfer function
% There are several data sets in this folder. Muscles are first initialized with some pressure then a step input is fed to record the response.
% We gradually increase the initial pressure in muscle1 in different experiments.
% However, the sum of the pressure in muscle1 and muscle2 is always kept constant to 4.2bar. 
% The identification is done considering delta P as input and position of the elbow as output. 
% In every data set, Varname6 is the pressure in muscle1 which is the input and 
% Varname8 is the output angular position.
% The Input-output pair is created from Varname6 and Varname8.
% xlow to Xup is the region of interest for creating input-output data pair for identification. 

step1: Bring a particular dataset to the workspace.
Step2: Choose the region of interest in plot(Varname8) which covers the transient behavour or see the datainfo.csv
Step3: Select the different 
%%
s = tf('s');


xlow = 4700
xup =  5500;

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
inputdata = VarName6(xlow:xup)  - VarName6(xlow);
outputdata = VarName8(xlow:xup) - VarName8(xlow);
U = inputdata;
O = outputdata;
%% Idadat
%Ze = iddata(VarName8(1630:11630), U', 0.01);
figure(1)
%bode(Ze)
%% Simulate the system
%pneumaticarm_sys = exp(-s*0.23)*K_gain*wn^2/(s^2 + 2*damping_ratio*wn*s + wn^2) - 0.09/2.2
pneumaticarm_sys = tfdelpinitpres7%exp(-s*0.11)*K_gain*wn^2/(s^2 + 2*damping_ratio*wn*s + wn^2);
%plot(2*step(pneumaticarm_sys))

ss_sys = ss(pneumaticarm_sys)
X0 = [ VarName8(xlow);0;0];
T= 0:0.01:(xup -xlow)*0.01;
identifiedsysresponse = VarName8(xlow) + lsim(ss_sys, U, T); %VarName8(xlow) + lsim(pneumaticarm_sys, U, T);
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
 plot(VarName1(xrange_low:xrange_up), identifiedsysresponse, 'r');%plot (211),
hold on
plot(VarName1(xrange_low:xrange_up), VarName8(xrange_low:xrange_up), 'g'); %subplot(211), 
xlabel('Time');
ylabel('Angular position elbow (rad)');

% subplot(212), plot(VarName1(xrange_low:xrange_up), VarName6(xrange_low:xrange_up), 'g');
% hold on
% subplot(212), plot(VarName1(xrange_low:xrange_up), U, 'r');
% %inputdataidentsinewave = U';
%outputdataidentsinewave = VarName8(1:xrange);

% [A1, B1] = ssdata(tfdelpinitpres1)
% [A2, B2] = ssdata(tfdelpinitpres2)
% [A41, B41] = ssdata(tfdelpinitpres41)
% [A6, B6] = ssdata(tfdelpinitpres6)
% [A7, B7] = ssdata(tfdelpinitpres7)
% [A8, B8] = ssdata(tfdelpinitpres8)
% [A9, B9] = ssdata(tfdelpinitpres9)
% [A10, B10] = ssdata(tfdelpinitpres10)
% statespace1 = [A1, B1];
% statespace2 = [A2, B2];
% statespace41 = [A41, B41]
% statespace6 = [A6, B6];
% statespace7 = [A7, B7];
% statespace8 = [A8, B8]; 
% statespace9 = [A9, B9];
% statespace10 = [A10, B10]; 
% [A1, B1] = ssdata(tfdelpinitpres1)
% [A1, B1] = ssdata(tfdelpinitpres1)