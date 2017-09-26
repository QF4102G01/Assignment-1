function [cdo] = EuropeanDownAndOutCall(S0, q, H, X, tau, r, sigma)
  lambda = (r - q) / (sigma ^ 2) - 0.5;
  y = (log(H ^ 2 * X ./ S0) + lambda * sigma ^ 2 * tau) / (sigma * tau ^ 0.5);
  x1 = (log(S0./H) + lambda * sigma ^ 2 * tau) / (sigma * tau ^ 0.5);
  y1 = (-log(S0./H) + lambda * sigma ^ 2 * tau) / (sigma * tau ^ 0.5);
  c = EuropeanVanillaCall(S0, q, X, tau, r, sigma);
  
  if H <=  X
      % I think this formula given is wrong.
      %cdo = c - S0.* normcdf(y).* exp(-q * tau).* (H./ S0).^ (2 * lambda) + X.* exp(-r * tau).* normcdf(y - sigma * tau ^ 0.5).* (H./S0).^ (2 * lambda - 2);
      cdo = c - (H./ S0).^ (2 * lambda) * EuropeanVanillaCall(H^2 ./ S0, q, X, tau, r, sigma);
  else
      cdo = S0.* normcdf(x1).* exp(-q * tau) - X.* exp(-r * tau).* normcdf(x1 - sigma * tau ^ 0.5) - (H./S0).^ (2 * lambda) .* S0.* exp(-q * tau).* normcdf(y1) + X.* exp(-r * tau).* normcdf(y1 - sigma * tau ^ 0.5) .* (H./S0).^ (2 * lambda - 2);
  end
end

function [c] = EuroVanila(S0, q, H, X, tau, r, sigma)
    d1 = (log(S0/X) + (r - q + sigma ^ 2) * tau) / (sigma * sqrt(tau)
    d2 = d1 - sigma * sqrt(tau)
    