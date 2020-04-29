function [X,labels]=generate_gaussian_circles(nsamples,radial_centers,decay_length)
%A simple function that generates randomly distributed circles discs, and
%their corresponding labels

    ncircles = length(radial_centers);
    nsamples_tot = sum(nsamples);
    X = zeros(nsamples_tot,2);
    labels = zeros(nsamples_tot,1);
    idx0 = 1;
    idx1 = 0;
    for i = 1:ncircles
        r = radial_centers(i) + decay_length(i) .*randn(nsamples(i),1);
        angle = 2*pi*rand(nsamples(i),1);
        [x,y] = pol2cart(angle,r);
        idx1 = idx1 + nsamples(i);
        X(idx0:idx1,1) = squeeze(x);
        X(idx0:idx1,2) = squeeze(y);
        labels(idx0:idx1) = i;
        idx0 = idx1+1;
    end
end