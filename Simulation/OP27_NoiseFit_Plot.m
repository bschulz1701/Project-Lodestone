% LogI = log(OP27Noise_i.i);
% LogF = log(OP27Noise_i.f);
% 
% p = polyfit(LogF, LogI, 2);
% ModelF = linspace(10,4000,1000);
% ModelI = polyval(p, ModelF);
% ModelI = p(1)*(ModelF.^2) + p(2)*ModelF + p(3);
% ModelI = p(1)*ModelF + p(2);
% ModelLogF = exp(ModelF);
% ModelLogI = exp(ModelI);
% 
% q = polyfit(OP27Noise_i.f, OP27Noise_i.i, 2);
% ModelFLin = linspace(10, 4000, 1000);
% ModelILin = polyval(p, ModelFLin);

f = logspace(-2, 4, 50);

x = OP27Noise_i.f;
y = OP27Noise_i.i*1e-12; %Change units to pA/sqrt(Hz)
% fit_fcn = @(b,x) x.^b(1) .* exp(b(2));                                  % Objective Function
% RNCF = @(b) norm(y - fit_fcn(b,x));                                     % Residual Norm Cost Function
% B = fminsearch(RNCF, [1; 1]);                                           % Estimate Parameters

Noise_I_Fit = polyfit(log(x),log(y),2);
Noise_I_Vals = exp(polyval(Noise_I_Fit,log(f))); 


x = OP27Noise_v.f;
y = OP27Noise_v.v*1e-9; %Change units to nV/sqrt(Hz)
% fit_fcn = @(b,x) x.^b(1) .* exp(b(2));                                  % Objective Function
% RNCF = @(b) norm(y - fit_fcn(b,x));                                     % Residual Norm Cost Function
% B = fminsearch(RNCF, [1; 1]);                                           % Estimate Parameters

Noise_V_Fit = polyfit(log(x),log(y),2);
Noise_V_Vals = exp(polyval(Noise_V_Fit,log(f))); 
 
close all
loglog(OP27Noise_i.f, OP27Noise_i.i*1e-12);
hold on
% plot(ModelFLin, fit_fcn(B,ModelFLin));
loglog(f, Noise_I_Vals);

figure(2)
loglog(OP27Noise_v.f, OP27Noise_v.v*1e-9);
hold on
loglog(f, Noise_V_Vals);
% hold on
% plot(ModelLogF, ModelLogI);
shg