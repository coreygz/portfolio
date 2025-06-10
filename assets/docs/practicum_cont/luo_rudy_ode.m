R = 8.31446261815324; % ideal gas constant, J / (K*mol)
F = 96485.3321233; % Faraday's constant, C / mol
T = 37 + 273.15; % temperature of preparation, K 
RTF = 1000*R*T/F; % mV

% R = 8314;
% F = 96484.6;
% T = 310;
% RFT = R*T/F;

PR_NaK = 0.01833; % Na/K permeability ratio, unitless
C_m = 1; % membrane capacitance, uF/cm^2

% concentration of ions
% K_o = 5.4; % K outside, mM (parameter)
K_o = 7;
K_i = 145; % K inside, mM
Na_i = 18; % Na inside, mM
Na_o = 140; % Na outside, mM
Ca_o = 1.8; % Ca outside, mM

% maximum conductance of channels
G_Na = 23; % Na channel, mS / cm^2
G_si = 0.09; % slow inward channel, mS / cm^2
G_K = 0.282 * sqrt(K_o/5.4); % time-dependent K channel, mS / cm^2
G_K1 = 0.6047 * sqrt(K_o/5.4); % time-independent K channel, mS / cm^2
G_Kp = 0.0183; % plateau K channel, mS / cm^2
G_b = 0.03921; % background, mS / cm^2

% reversal potentials
E_Na = RTF * log(Na_o/Na_i); % Na potential, mV
% E_Na = 54.4; % Na potential, mV
E_K = RTF * log((K_o+PR_NaK*Na_o)/(K_i+PR_NaK*Na_i)); % K potential, mV
% E_K = -77; % time-dependent K potential, mV
E_K1 = RTF * log(K_o/K_i); % time-independent K potential, mV
% E_K1 = -50;
E_Kp = E_K1; % plateau K potential, mV
% Are these values right???
E_b = -59.87; % background, mV

% gating variable functions
a_h = @(V) (V < -40) .* (0.135*exp((80+V)/-6.8));
b_h = @(V) ...
    (V >= -40) .* (1./(0.13*(1+exp((V+10.66)/-11.1)))) + ...
    (V < -40) .* (3.56*exp(0.079*V)+3.1*(10^5)*exp(0.35*V));
a_j = @(V) ...
    (V < -40) .* (-1.2714*(10^5)*exp(0.2444*V) - 3.474*(10^-5)*exp(-0.04391*V)) ...
        .* (V+37.78) ./ (1+exp(0.311*(V+79.23)));
b_j = @(V) ...
    (V >= -40) .* (0.3*exp(-2.535*(10^-7)*V)) ./ (1+exp(-0.1*(V+32))) + ...
    (V < -40) .* (0.1212*exp(-0.01052*V)) ./ (1 + exp(-0.1378*(V+40.14)));
a_m = @(V) 0.32*(V+47.13)./(1-exp(-0.1*(V+47.13)));
b_m = @(V) 0.08*exp(-V/11);
a_d = @(V) 0.095*exp(-0.01*(V-5)) ./ (1+exp(-0.072*(V-5)));
b_d = @(V) 0.07*exp(-0.017*(V+44)) ./ (1+exp(0.05*(V+44)));
a_f = @(V) 0.012*exp(-0.008*(V+28)) ./ (1+exp(0.15*(V+28)));
b_f = @(V) 0.0065*exp(-0.02*(V+30)) ./ (1+exp(-0.2*(V+30)));
X_i = @(V) ...
    (V > -100) .* (2.837*(exp(0.04*(V+77))-1) ./ ((V+77).*exp(0.04*(V+35)))) + ...
    (V <= -100);
a_X = @(V) 0.0005*exp(0.083*(V+50)) ./ (1+exp(0.057*(V+50)));
b_X = @(V) 0.0013*exp(-0.06*(V+20)) ./ (1+exp(-0.04*(V+20)));
a_K1 = @(V) 1.02 ./ (1+exp(0.2385*(V-E_K1-59.215)));
b_K1 = @(V) (0.49124*exp(0.08032*(V-E_K1+5.476)) + exp(0.06175*(V-E_K1-594.31))) ...
    ./ (1+exp(-0.5143*(V-E_K1+4.753)));
K1 = @(V) a_K1(V) ./ (a_K1(V) + b_K1(V));
Kp = @(V) 1 ./ (1+exp((7.488-V)/5.98));

% initializing model
t_final = 600;
dt = 0.0025;
time_steps = int64(t_final / dt);

V = zeros(1,time_steps);
h = zeros(1,time_steps);
j = zeros(1,time_steps);
m = zeros(1,time_steps);
d = zeros(1,time_steps);
f = zeros(1,time_steps);
X = zeros(1,time_steps);
Ca_i = zeros(1,time_steps);

V0 = -84.547997;
h0 = a_h(V0) / (a_h(V0) + b_h(V0));
j0 = a_j(V0) / (a_j(V0) + b_j(V0));
m0 = a_m(V0) / (a_m(V0) + b_m(V0));
d0 = a_d(V0) / (a_d(V0) + b_d(V0));
f0 = a_f(V0) / (a_f(V0) + b_f(V0));
X0 = a_X(V0) / (a_X(V0) + b_X(V0));
Ca_i0 = 0.000178;

V(1) = V0;
h(1) = h0;
j(1) = j0;
m(1) = m0;
d(1) = d0;
f(1) = f0;
X(1) = X0;
Ca_i(1) = Ca_i0;

% period = 500;
% duration = 0.5;
% I_st = 80*repmat(...
%     [ones(1,duration/dt) zeros(1, (period - duration)/dt)], ...
%     1, ceil(t_final/duration));

I_st = zeros(1,time_steps);
I_st(50/dt+1:50.5/dt) = 80*ones(1,0.5/dt);
% I_st(1:0.25/dt) = 200*ones(1,0.25/dt);
% I_st(1:85/dt) = 2.2*ones(1,85/dt);
% I_st(1:100/dt) = 2.165*ones(1,100/dt);
% I_st(1:100/dt) = 1.77*ones(1,100/dt);
% I_st(150001:155000) = 3*ones(1,5000);
% I_st = 2.4*ones(1,time_steps);

for i = 1:time_steps
    E_si = 7.7 - 13.0287*log(Ca_i(i));
    
    I_Na = G_Na * m(i)^3 * h(i) * j(i) * (V(i) - E_Na);
    I_si = G_si * d(i) * f(i) * (V(i) - E_si);
    I_K = G_K * X(i) * X_i(V(i)) * (V(i) - E_K);
    I_K1 = G_K1 * K1(V(i)) * (V(i) - E_K1);
    I_Kp = G_Kp * Kp(V(i)) * (V(i) - E_Kp);
    I_b = G_b * (V(i) - E_b);
    
    I_ion = I_Na + I_si + I_K + I_K1 + I_Kp + I_b;
    
    V(i+1) = V(i) + dt*(1/C_m)*(I_st(i) - I_ion);
    h(i+1) = h(i) + dt*(a_h(V(i))*(1-h(i)) - b_h(V(i))*h(i));
    j(i+1) = j(i) + dt*(a_j(V(i))*(1-j(i)) - b_j(V(i))*j(i));
    m(i+1) = m(i) + dt*(a_m(V(i))*(1-m(i)) - b_m(V(i))*m(i));
    d(i+1) = d(i) + dt*(a_d(V(i))*(1-d(i)) - b_d(V(i))*d(i));
    f(i+1) = f(i) + dt*(a_f(V(i))*(1-f(i)) - b_f(V(i))*f(i));
    X(i+1) = X(i) + dt*(a_X(V(i))*(1-X(i)) - b_X(V(i))*X(i));
    Ca_i(i+1) = Ca_i(i) + dt*((-10^-4)*I_si + 0.07*((10^-4) - Ca_i(i)));
    
    if isnan(V(i+1))
        break
    end

end

plot(0:dt:t_final, V, "LineWidth", 2.0)
xlabel("Time (ms)", "FontSize", 16)
ylabel("Membrane Potential (mV)", "FontSize", 16)
title("Luo-Rudy Action Potential", "FontSize", 18)
saveas(gcf, "luo-rudy_single.png", "png")

plot(0:dt:t_final, ...
    (G_K1 * K1(V) .* (V - E_K1)) + ...
    (G_Kp * Kp(V) .* (V - E_Kp)) + ...
    (G_b * (V - E_b)), "LineWidth", 2.0)
xlabel("Time (ms)", "FontSize", 16)
ylabel("Membrane Potential (mV)", "FontSize", 16)
title("Luo-Rudy Action Potential", "FontSize", 18)