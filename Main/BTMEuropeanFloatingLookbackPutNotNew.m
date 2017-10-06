function optionPrice = BTMEuropeanFloatingLookbackPutNotNew(S0, sigma, q, r, tau, N, runningMax)
	deltaT = tau / N;
	deltaX = sigma * deltaT ^ 0.5;
	u = exp(deltaX);
	d = 1 / u;
	p = (exp((r-q)*deltaT)-d) / (u-d);
	x0 = log(runningMax / S0);
	j = floor(x0 / deltaX);
	discountFactor = exp(-r*deltaT);
	k = max(j - N, 0) : 1 : N;
	kshift = 1;
	W(k + kshift) = exp(k.*deltaX) - 1;
	for i = N-1 : -1 : 0
		k = 1 : 1 : i;
		ZerothElement = discountFactor * (p * u * W(0 + kshift) + (1-p) * d * W(1 + kshift));
		W(k + kshift) = discountFactor * (p * u * W(k + kshift - 1) + (1-p) * d * W(k + kshift + 1));
		W(0 + kshift) = ZerothElement;
	end
	alpha = (x0 - j * deltaX) / deltaX;
	optionPrice = S0 * ((1 - alpha) * W(j + kshift) + alpha * W(j+1 + kshift));
end