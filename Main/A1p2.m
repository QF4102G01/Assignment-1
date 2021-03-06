%Group members: Chen Penghao, Wang Zexin
%Group number: G01

format long

%prepare the parameters
tau = 0.5;
S0 = 1;
sigma = 0.4;
q = 0.02;
r = 0.04;
plotting_index = 200:200:20000;

%obtain the newly issued BTM floating lookback put option values
BTM_floatingLBP_ni_values = 200:200:20000;
for N = 200:200:20000
    BTM_floatingLBP_ni_values(N/200) = BTMEuropeanFloatingLookbackPut(S0, sigma, q, r, tau, N);
end

%redo with previously issued BTM floating lookback with running maximum of
%1.3 dollars
running_max = 1.3;
BTM_floatingLBP_pi_values = 200:200:20000;
for N = 200:200:20000
    BTM_floatingLBP_pi_values(N/200) = BTMEuropeanFloatingLookbackPutNotNew(S0, sigma, q, r, tau, N, running_max);
end

%plot the option values against N
plot(plotting_index, BTM_floatingLBP_ni_values);
title({'Plot of newly issued floating strike lookback put option values', ...
       'obtained by BTM against number of time steps'});
xlabel('Number of time steps/N');
ylabel('Newly issued floating strike lookback put option value using BTM');
figure;
plot(plotting_index, BTM_floatingLBP_pi_values, 'r');
title({'Plot of previously issued floating strike lookback put option values', ...
      'obtained by BTM against number of time steps'});
xlabel('Number of time steps/N');
ylabel('Previously issued floating strike lookback put option value');
