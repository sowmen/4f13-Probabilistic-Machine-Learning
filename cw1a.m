load('cw1a.mat');
xs = linspace(-4, 4, 1000)';

meanfunc = [];

covfunc = @covSEiso;

likfunc = @likGauss;

hyp = struct('mean', [], 'cov', [-1 0], 'lik', 0);

hyp2 = minimize(hyp, @gp, -200, @infGaussLik, meanfunc, covfunc, likfunc, x, y);

% make predictions 
[mu s2] = gp(hyp2, @infGaussLik, meanfunc, covfunc, likfunc, x, y, xs);

% plot the predictive mean
f = [mu+2*sqrt(s2); flipdim(mu-2*sqrt(s2),1)];
fill([xs; flipdim(xs,1)], f, [5 5.5 8]/8, 'LineStyle', 'none');
hold on; plot(xs, mu,'r'); plot(x, y, 'bx')
