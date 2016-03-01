function labels = C2_labels(sigma, sz)
    labels=[];
	[rs, cs] = ndgrid((1:sz(1)) - floor(sz(1)/2), (1:sz(2)) - floor(sz(2)/2));
    for item=1:numel(sigma)
        label = exp(-0.5 / sigma(item)^2 * (rs.^2 + cs.^2));
        label(floor(sz(1)/2),floor(sz(2)/2)) = 1;
        labels=cat(3,labels,label);
    end
end

