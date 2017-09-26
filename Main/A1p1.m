format long

S0 = 7:0.1:10;
q = 0.00;
H = 7;
X = 6.5;
tau = 0.5;
r = 0.02;
sigma = 0.3;

cdoPrices = EuropeanDownAndOutCall(S0, q, H, X, tau, r, sigma);

plot(S0, cdoPrices);

hold on;

cPrices = EuropeanVanillaCall(S0, q, X, tau, r, sigma);

plot(S0, cPrices);

hold off;

BTMcdoPrices = 2100 : 2500;
for N = 2100 : 2500
    BTMcdoPrices(N - 2099) = BTMEuropeanDownAndOutCall(8, q, 6, X, tau, r, sigma, N);
end

cdoPrice = EuropeanDownAndOutCall(8, q, 6, X, tau, r, sigma);

plot(2100 : 2500, BTMcdoPrices);

localErrors = BTMcdoPrices - cdoPrice;

minN1 = find(localErrors == min(localErrors)) + 209; % minimum error

minI1 = ceil(log(6 / 8) / (sigma * sqrt(tau / minN1)));

minH1 = 8 * exp(minI1 * sigma * sqrt(tau / minN1));

minN2 = find(localErrors == min(localErrors(localErrors > min(localErrors)))) + 209; % second minimum error

minI2 = ceil(log(6 / 8) / (sigma * sqrt(tau / minN2)));

minH2 = 8 * exp(minI2 * sigma * sqrt(tau / minN2));

