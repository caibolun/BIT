function out = get_ROI(im, pos, sz)

    xs = floor(pos(2)) + (1:sz(2)) - floor(sz(2)/2);
    ys = floor(pos(1)) + (1:sz(1)) - floor(sz(1)/2);
	
    xs(xs < 1) = 1;
    ys(ys < 1) = 1;
    xs(xs > size(im,2)) = size(im,2);
    ys(ys > size(im,1)) = size(im,1);
	
    out = im(ys, xs, :);
end

