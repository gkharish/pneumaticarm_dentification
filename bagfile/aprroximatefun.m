
coeff0 = [damping_ratio wn];
coeff1 = -coeff(1)*coeff(2);
coeff2 = sqrt(1- coeff(1)^2);
coeff3 = coeff(2)*coeff2;
coeff4 = asin(coeff2);
i=1;
for t= 0:0.01:100
y_predicted(i) = 0.897 - (exp(coeff1*t)/coeff2)*sin(coeff3*t + coeff4);
i=1+i;
end
y_predicted = y_predicted';


%% Least square fit

xdata = U;
ydata = VarName8(1630:11630);
x0 = coeff0;
[x,resnorm] = lsqcurvefit(y_predicted,x0,xdata,ydata);