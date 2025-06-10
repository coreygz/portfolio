R = 8.31446261815324; % ideal gas constant, J / (K*mol)
F = 96485.3321233; % Faraday's constant, C / mol
T = 37 + 273.15; % temperature of preparation, K 
RTF = 1000*R*T/F; % mV

PR_NaK = 0.01833; % Na/K permeability ratio, unitless
C_m = 1; % membrane capacitance, uF/cm^2
R_a = 10; % axial resistance, kOhms

% concentration of ions
K_o = 5.4; % K outside, mM (parameter)
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
E_K = RTF * log((K_o+PR_NaK*Na_o)/(K_i+PR_NaK*Na_i)); % K potential, mV
E_K1 = RTF * log(K_o/K_i); % time-independent K potential, mV
E_Kp = E_K1; % plateau K potential, mV
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

% parameters for step size
total_length = 30; % length of cardiac fiber, mm
total_time = 1000; % total time

dx = 0.5; % step size for spatial dimension, mm (0.004)
dt = 0.01; % step size for temporal dimension

space_steps = total_length / dx;
time_steps = total_time / dt;

% stimulus current
% I_st = zeros(time_steps,space_steps);
% I_st(1:0.5/dt,1) = 80*ones(0.5/dt,1);

period = 500;
duration = 0.5;
stimulus = 80*repmat(...
    [ones(1,duration/dt) zeros(1, (period - duration)/dt)], ...
    1, ceil(t_final/duration));

I_st = zeros(time_steps,space_steps);
I_st(:,1) = stimulus(1:time_steps);


% pre-initializing variables
V = zeros(time_steps,space_steps);
m = zeros(time_steps,space_steps);
h = zeros(time_steps,space_steps);
j = zeros(time_steps,space_steps);
d = zeros(time_steps,space_steps);
f = zeros(time_steps,space_steps);
X = zeros(time_steps,space_steps);
Ca_i = zeros(time_steps,space_steps);

% initial values
V0 = -84.547997;
h0 = a_h(V0) / (a_h(V0) + b_h(V0));
j0 = a_j(V0) / (a_j(V0) + b_j(V0));
m0 = a_m(V0) / (a_m(V0) + b_m(V0));
d0 = a_d(V0) / (a_d(V0) + b_d(V0));
f0 = a_f(V0) / (a_f(V0) + b_f(V0));
X0 = a_X(V0) / (a_X(V0) + b_X(V0));
Ca_i0 = 0.000178;

% boundary and initial conditions for voltage
V(1,:) = V0*ones(1,space_steps); % initial conditions

% initial conditions for ODE variables
m(1,:) = m0*ones(1,space_steps);
h(1,:) = h0*ones(1,space_steps);
j(1,:) = j0*ones(1,space_steps);
d(1,:) = d0*ones(1,space_steps);
f(1,:) = f0*ones(1,space_steps);
X(1,:) = X0*ones(1,space_steps);
Ca_i(1,:) = Ca_i0*ones(1,space_steps);

% time for the actual computation
for i=1:time_steps
    E_si = 7.7 - 13.0287*log(Ca_i(i,:));
    
    I_Na = G_Na * m(i,:).^3 .* h(i,:) .* (V(i,:) - E_Na);
    I_si = G_si * d(i,:) .* f(i,:) .* (V(i,:) - E_si);
    I_K = G_K * X(i,:) .* X_i(V(i,:)) .* (V(i,:) - E_K);
    I_K1 = G_K1 * K1(V(i,:)) .* (V(i,:) - E_K1);
    I_Kp = G_Kp * Kp(V(i,:)) .* (V(i,:) - E_Kp);
    I_b = G_b * (V(i,:) - E_b);
    
    I_ion = I_Na + I_si + I_K + I_K1 + I_Kp + I_b;
    
    V(i+1,:) = V(i,:) + dt*(1/C_m)*(central_diff(V(i,:),dx)/R_a - I_ion + I_st(i,:));
    
    m(i+1,:) = m(i,:) + dt*((1 - m(i,:)).*a_m(V(i,:)) - m(i,:).*b_m(V(i,:)));
    h(i+1,:) = h(i,:) + dt*((1 - h(i,:)).*a_h(V(i,:)) - h(i,:).*b_h(V(i,:)));
    j(i+1,:) = j(i,:) + dt*((1 - j(i,:)).*a_j(V(i,:)) - j(i,:).*b_j(V(i,:)));
    d(i+1,:) = d(i,:) + dt*((1 - d(i,:)).*a_d(V(i,:)) - d(i,:).*b_d(V(i,:)));
    f(i+1,:) = f(i,:) + dt*((1 - f(i,:)).*a_f(V(i,:)) - f(i,:).*b_f(V(i,:)));
    X(i+1,:) = X(i,:) + dt*((1 - X(i,:)).*a_X(V(i,:)) - X(i,:).*b_X(V(i,:)));
    Ca_i(i+1,:) = Ca_i(i,:) + dt*((-10^-4)*I_si + 0.07*((10^-4) - Ca_i(i,:)));
end

for t = 1:100:time_steps
   plot(1:space_steps, V(t,:));
   axis([1 space_steps -90 60]);
   pause(0.01);
end

function V = central_diff(V,dx)
    V = conv(V, [1 -2 1], 'same') / dx^2;
    V(1) = 0;
    V(end) = 0;
end
