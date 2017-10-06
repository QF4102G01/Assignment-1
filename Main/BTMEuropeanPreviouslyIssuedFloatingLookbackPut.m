function optionPrice = BTMEuropeanPreviouslyIssuedFloatingLookbackPut(S0, sigma, q, r, tau, N, running_max)
	deltaT = tau / N;
	deltaX = sigma * deltaT ^ 0.5;
    
    x0 = log(max(S0, running_max)/S0);
    j = floor(x0 / deltaX);
    
	u = exp(deltaX);
	d = 1 / u;
	p = (exp(deltaT * (r-q)) - d) / (u - d);
	discountFactor = exp(-r * deltaT);
    
	k = max(j-N, 0) : 1 : j+N+1;
	kshift = 1;
	W(k + kshift) = exp(k * deltaX) - 1;
	for i = N-1 : -1 : 0
        if j-i <= 0
            ZerothElement = discountFactor * (p * u * W(0 + kshift) + (1-p) * d * W(1 + kshift));
            W(0 + kshift) = ZerothElement;
        end
		k = max(j-i, 1) : 1 : j + i + 1;
		W(k + kshift) = discountFactor * (p * u * W(k + kshift - 1) + (1-p) * d * W(k + kshift + 1));
	end
	optionPrice = S0 * W(0 + kshift);
end