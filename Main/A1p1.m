%Group members: Chen Penghao, Wang Zexin
%Group number: G01

format long

%prepare the parameters
S0 = 7:0.1:10;
q = 0.00;
H = 7;
X = 6.5;
tau = 0.5;
r = 0.02;
sigma = 0.3;

%obtain the European down-and-out call option values
cdoPrices = EuropeanDownAndOutCall(S0, q, H, X, tau, r, sigma);

%plot these values against S0
plot(S0, cdoPrices);

hold on;

%obtain the vanilla European call option values
cPrices = EuropeanVanillaCall(S0, q, X, tau, r, sigma);

%plot these values on the same graph against S0
plot(S0, cPrices);

hold off;

%implement BTM for European down-and-out call option
BTMcdoPrices = 2100 : 2500;
for N = 2100 : 2500
    BTMcdoPrices(N - 2099) = BTMEuropeanDownAndOutCall(8, q, 6, X, tau, r, sigma, N);
end

cdoPrice = EuropeanDownAndOutCall(8, q, 6, X, tau, r, sigma);

%plot these call option values aginst N
plot(2100 : 2500, BTMcdoPrices);

%obtain the errors computed under BTM by comparing against that computed
%under the Black-Scholes formula
localErrors = BTMcdoPrices - cdoPrice;

minN1 = find(localErrors == min(localErrors)) + 209; % minimum error

minI1 = ceil(log(6 / 8) / (sigma * sqrt(tau / minN1)));

minH1 = 8 * exp(minI1 * sigma * sqrt(tau / minN1));

minN2 = find(localErrors == min(localErrors(localErrors > min(localErrors)))) + 209; % second minimum error

minI2 = ceil(log(6 / 8) / (sigma * sqrt(tau / minN2)));

minH2 = 8 * exp(minI2 * sigma * sqrt(tau / minN2));

