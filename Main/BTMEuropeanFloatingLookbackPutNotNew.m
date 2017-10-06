function optionPrice = BTMEuropeanFloatingLookbackPutNotNew(S0, sigma, q, r, tau, N, running_max)
	%prepare the deltaX and discount factor
    deltaT = tau / N;
	deltaX = sigma * deltaT ^ 0.5;
    discountFactor = exp(-r * deltaT);
    
    %prepare j
    x0 = log(max(S0, running_max)/S0);
    j = floor(x0 / deltaX);
    
    %prepare u, d and hence p
	u = exp(deltaX);
	d = 1 / u;
	p = (exp(deltaT * (r-q)) - d) / (u - d);

    %initialization
	k = max(j-N, 0) : 1 : j+N+1;
	kshift = 1;
	W(k + kshift) = exp(k * deltaX) - 1;
    
    %Backward iterations
	for i = N-1 : -1 : 0
		k = 1 : 1 : i;
		ZerothElement = discountFactor * (p * u * W(0 + kshift) + (1-p) * d * W(1 + kshift));
		W(k + kshift) = discountFactor * (p * u * W(k + kshift - 1) + (1-p) * d * W(k + kshift + 1));
		W(0 + kshift) = ZerothElement;
	end
    
    %interpolating between S0W0j and S0W0j+1
	alpha = (x0 - j * deltaX) / deltaX;
	optionPrice = S0 * ((1 - alpha) * W(j + kshift) + alpha * W(j+1 + kshift));
end