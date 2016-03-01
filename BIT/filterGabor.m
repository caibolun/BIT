function fodd = filterGabor( xi, sig, lambda)

r = floor(xi/2);

x = -r:r;
fodd  = -sin(2*pi*x/lambda) .* exp(-(x.^2)/(2*sig^2));

% normalize to mean==0, but only in locs that are nonzero
inds = abs(fodd)>.00001;  fodd(inds) = fodd(inds) - mean(fodd(inds));

fodd = 0.5*fodd;
