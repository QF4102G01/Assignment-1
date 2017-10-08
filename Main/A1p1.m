%Group members: Chen Penghao, Wang Zexin
%Group number: G01

format long

%prepare the parameters
S0 = 7:0.1:10;
q = 0.00;
H7 = 7;
X = 6.5;
tau = 0.5;
r = 0.02;
sigma = 0.3;

%obtain the European down-and-out call option values with H=7
cdoPrices7 = EuropeanDownAndOutCall(S0, q, H7, X, tau, r, sigma);

%obtain the European down-and-out call option values with H=6
H6 = 6;
cdoPrices6 = EuropeanDownAndOutCall(S0, q, H6, X, tau, r, sigma);

%obtain the vanilla European call option values
cPrices = EuropeanVanillaCall(S0, q, X, tau, r, sigma);

%plot these values against S0
hold on;
plot(S0, cdoPrices7);
plot(S0, cdoPrices6);
plot(S0, cPrices);
title('Plot of option values against initial underlier price');
xlabel('Initial underlier price/S0');
ylabel('Option value after 0.5 year');
legend('European down-and-out option with H=7', ...
       'European down-and-out option with H=6', ...
       'European vanilla option', ...
       'Location', 'northwest');

hold off
figure;

%implement BTM for European down-and-out call option
BTMcdoPrices = 210 : 250;
for N = 210 : 250
    BTMcdoPrices(N - 209) = BTMEuropeanDownAndOutCall(8, q, 6, X, tau, r, sigma, N);
end

%plot errors aginst N
plot(210 : 250, BTMcdoPrices, 'r');
title('Plot of errors in BTM methods against number of time steps');
xlabel('Number of time steps/N');
ylabel('Errors in the result obtained via BTM');

%obtain cdoPrice using function
cdoPrice = EuropeanDownAndOutCall(8, q, 6, X, tau, r, sigma);

%obtain the errors computed under BTM by comparing against that computed
%under the Black-Scholes formula
localErrors = BTMcdoPrices - cdoPrice;

minN1 = find(localErrors == min(localErrors)) + 209; % minimum error

minI1 = ceil(log(6 / 8) / (sigma * sqrt(tau / minN1)));

minH1 = 8 * exp(minI1 * sigma * sqrt(tau / minN1));

minN2 = find(localErrors == min(localErrors(localErrors > min(localErrors)))) + 209; % second minimum error

minI2 = ceil(log(6 / 8) / (sigma * sqrt(tau / minN2)));

minH2 = 8 * exp(minI2 * sigma * sqrt(tau / minN2));

disp(['First value of N yielding the locally minimum errors is ', num2str(minN1)]);
disp(['Second value of N yielding the locally minimum errors is ', num2str(minN2)]);
