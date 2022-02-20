function ts = gents
% GENTS Generates a random piecewise continuous timeseries with about 1000
% time points between [0 100] with ~10 discontinuities.

% By: Murali Yeddanapudi, 18-Feb-2022

%%
n = 1001;
nb = 10;

tmax = 100;
t = linspace(0,tmax,n);

%%
% Generate the continuous segments as a sum of 5 sinusoids with random
% amplitude and frequency.
nsig = 5;
amin = 0.5;
amax = 1.5;
pmin = 10;
pmax = 30;
y = zeros(size(t));
for is=1:nsig
    a = amin + (amax-amin)*rand;
    p = pmin + (pmax-pmin)*rand;
    f = 2*pi*p/tmax;
    y = y + a*sin(f*t);
end

%%
% Randomly select 'nb' time points to insert discontinuities. Size the
% discontinuity to be about the same magnitude as the continuous segments
bidx = cumsum(2*ceil((n/nb)*rand(1,nb)));
bidx = bidx(bidx < n);
ymin = min(y);
ymax = max(y);
yrng = ymax-ymin;
for ib=1:numel(bidx)
    idx = bidx(ib);
    t = [t(1:idx) t(idx:end)];
    yb = 2*yrng*rand - yrng;
    y = [y(1:idx) yb + y(idx:end)];
end

%%
ts = timeseries(y',t');
