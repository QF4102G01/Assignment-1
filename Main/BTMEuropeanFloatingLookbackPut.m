%Group members: Chen Penghao, Wang Zexin
%Group number: G01

function optionPrice = BTMEuropeanFloatingLookbackPut(S0, sigma, q, r, tau, N)
    %prepare deltaX and discount factor
	deltaT = tau / N;
	deltaX = sigma * deltaT ^ 0.5;
    discountFactor = exp(-r * deltaT);
    
    %prepare u, d and hence p
	u = exp(deltaX);
	d = 1 / u;
	p = (exp(deltaT * (r-q)) - d) / (u - d);

    %initialization
	k = 0 : 1 : N;
	kshift = 1;
	W(k + kshift) = exp(k * deltaX) - 1;
    
    %backward iteration
	for i = N-1 : -1 : 0
		k = 1 : 1 : i;
		ZerothElement = discountFactor * (p * u * W(0 + kshift) + (1-p) * d * W(1 + kshift));
		W(k + kshift) = discountFactor * (p * u * W(k + kshift - 1) + (1-p) * d * W(k + kshift + 1));
		W(0 + kshift) = ZerothElement;
    end
    
    %obtain option value
	optionPrice = S0 * W(0 + kshift);
end