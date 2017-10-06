function [cdo] = BTMEuropeanDownAndOutCall(S0, q, H, X, tau, r, sigma, N)
    %prepare dt, dx and hence discount factor
    dt = tau / N;
    dx = sigma * sqrt(dt);
    df = exp(-r * dt);
    
    %prepare u, d and hence p
    u = exp(dx);
    d = 1 / u;
    p = (exp((r-q) * dt) - d) / (u - d);
    
    %initialization
    j = 0 : 1 : N; jshift = 1;
    V(j + jshift) = max(S0 .* u .^ (j .* 2 - N) - X, 0);
    
    %backward iteration
    for n = N-1 : -1 : 0
        j = 0 : 1 : n;
        V = df * ( p * V(j+1+jshift) + (1-p) * V(j+jshift) );
        boundaryJ = floor(log(H/S0)./(2 * dx) + n / 2);
        V(0 + jshift : boundaryJ + jshift) = 0;
    end
    
    %obtain option value
    cdo = V(0 + jshift);
end