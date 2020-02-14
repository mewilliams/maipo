
% Smax = 32;
% Smin = 4;
% So = Smax-Smin;
% Kx = 400;
% t = 400;
% xc = -4000;
% x = -10000:10000;
% 
% S = (So/2)*(1+erf((x-xc)/sqrt(4*Kx*t))) + Smin;
% plot(x,S), hold all
% 
% S = S+ rand(size(S))-rand(size(S));
% plot(x,S,'.')
% % lhse = 
% 
% S = (So/2)*(1+erf((x-xc)/sqrt(4*Kx*t))) + Smin;
% plot(x,S), hold all



smaxstar = 1;
t = 400;
x = -1000:1000;
xc = 0;
Kx = 300;
sstar = (smaxstar/2)*(1-erf((x-xc)/(sqrt(4*Kx*t))));
plot(x,sstar), hold all

