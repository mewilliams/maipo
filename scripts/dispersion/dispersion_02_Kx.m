% 8 feb 2020
% m williams
%
%


clear;
close all;

load ../../edited_data/dispersion_U_S_X_T.mat
X = XiS;
figure, plot(X,S,'.')

figure, plot(S,'.')
transidx = 489;

hold all
plot(1:transidx,S(1:transidx),'.')
plot(transidx:length(S),S(transidx:end),'.')

So = max(S) % -min(S);

Sebb = S(1:transidx);
Xebb = X(1:transidx);
Tebb = T(1:transidx);
Uebb = U(1:transidx);


LHSE = (2*Sebb/So - 1);
LHSE = erfinv(LHSE);
figure
plot(Xebb,LHSE,'.'), hold all

LHSE = LHSE(isfinite(Xebb));
Sebb = Sebb(isfinite(Xebb));
Xebb = Xebb(isfinite(Xebb));


Xebb = Xebb(isfinite(LHSE));
Sebb = Sebb(isfinite(LHSE));
LHSE = LHSE(isfinite(LHSE));
%%
p = polyfit(Xebb,LHSE',1)
hold all
xl = xlim;
plot(xl,p(1)*xl + p(2),'--')
legend('erf^{-1}(2*Sebb/So - 1)',[num2str(p(1)),'x + ',num2str(p(2))])