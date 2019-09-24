k = 1.38e-23; %Boltzmans constant 
M = 0.0227; %Moving Mass = 22.7g
f0 = 5; %Natural freq = 5Hz
zeta = 0.6; %Dampening factor
T = 293; %Assume room temp for all

S = 80; %Sensitivity, V/m/s

R2 = 0;
RF = 2.87e6;
R1 = 33.6*1000 + 54.9*1000;

vin_noise = Noise_V_Vals.^2 + (R2.^2)*(Noise_I_Vals.^2) + ((1/(1/R1 + 1/RF)).^2)*(Noise_I_Vals.^2) + 4*k*T*(R2 + (1/(1/R1 + 1/RF)));

Noise_SubI = ((1/(1/R1 + 1/RF)).^2)*(Noise_I_Vals.^2) + 4*k*T*(R2 + (1/(1/R1 + 1/RF)));

Noise_SubV = Noise_V_Vals.^2;

Snn = 16*(pi*k*T*zeta*f0)/M; %Calc suspension noise [(m/sec^2)^2/Hz]

close all
loglog(f, vin_noise./S, 's');
hold on

loglog(f, Noise_SubI./S);
% hold on
loglog(f, Noise_SubV./S);
line([min(f), max(f)], [Snn, Snn]);
% yyaxis right
% loglog(f, Noise_I_Vals.^2);
legend("Noise, Total", "Noise, Current Component", "Noise, Voltage Component", "Suspension Noise")
title({'Noise Amplitude Comparison','OP27, DT-SOLO'})
ylabel("Velocity Noise PSD ([m/s)^2/Hz]");
xlabel("Frequency [Hz]");
