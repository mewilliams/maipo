% 8 feb 2020
% m williams
%
%
poster_figure_startup

clear;
close all;
%%
load ../../raw_data/ysi_ctd/Maipo_YSI_CT.mat
tideidx = [0.7606E4:1.135E4];
figure(19), plot(ysi(1).time,ysi(1).sal), hold all
hold all
plot(ysi(1).time(tideidx),ysi(1).sal(tideidx))
s16short = ysi(1).sal(tideidx);
t16short = ysi(1).time(tideidx);


% return;


%%
xf = -30000:10000; % x fake.



load ../../edited_data/dispersion_analysis/maipo_UXS_aqd_fsi_2.mat
U_16dec = U;
X_16dec = X;
S_16dec = Sbin;
T_16dec = tbin;

i16ebb = 1:52;
S16ebb = S_16dec(i16ebb);
X16ebb = X_16dec(i16ebb);

medS16 = (max(S16ebb)+min(S16ebb))/2;
idx1 = find(s16short>medS16,1,'first')
t16shortmedS16 = interp1(s16short(idx1-1:idx1),t16short(idx1-1:idx1),medS16)
idx2 = find(s16short>medS16,1,'last')
timebetween_medS16 = t16short(idx2)-t16shortmedS16; % in days
timebetween_medS16_hours = timebetween_medS16*24;


figure(29)
plot(t16shortmedS16,medS16,'ko')
plot(t16short(idx2),medS16,'ko')
plot([t16shortmedS16 t16short(idx2)],medS16*ones(2,1),'k--')


% return;


[sstar,sstar_soln,p] = fit_inverse_erf(X16ebb,S16ebb,min(S16ebb),xf);
t16kx = timebetween_medS16*24*3600;
Kx = 1/(4*(p(1)^2)*t16kx)

[sstar0,sstar_soln0,p] = fit_inverse_erf(X16ebb,S16ebb,0,xf);
Kx_s0 = 1/(4*(p(1)^2)*(15.1333*3600)); % t = 15 hours and 8 min (from any salt enterring to leaving)

% return;

figure(19) 
subplot(2,1,2),
plot(X16ebb/1000,sstar,'ko'), hold all
plot(X16ebb/1000,sstar0,'o','color',[.8 .8 .8]), hold all
plot(X16ebb/1000,sstar,'ko'), hold all

plot(xf/1000,sstar_soln,'--')
plot(xf/1000,sstar_soln0,'-.') %,'color',[.8 .8 .8])
% plot(X16ebb/1000,sstar,'ko'),




legend({'S^* for S_{min} = 20.3','S^* for S_{min} = 0'},'box','off','location','best')

ylabel('$S^* = \frac{S - S_{min}}{S_{max}-S_{min}}$','interpreter','latex')

grid on
grid minor
xlabel('X (km)')
title('16 December')

%  return ;


load ../../edited_data/dispersion_U_S_X_T.mat
X = XiS;
figure, plot(X,S,'.')

figure, plot(S,'.')
transidx = 489;

hold all
plot(1:transidx,S(1:transidx),'.')
plot(transidx:length(S),S(transidx:end),'.')

% 15 because NaNs before. 
Sebb = S(15:transidx);
Xebb = X(15:transidx);
Tebb = T(15:transidx);
Uebb = U(15:transidx);

medS11 = (max(Sebb)+min(Sebb))/2;

minS = 0;
[sstar_mins0,sstar_soln_0,p] = fit_inverse_erf(Xebb,Sebb,minS,xf);
Kx_11pt5hours = 1/(4*(p(1)^2)*(11.5*3600)); % t = 15 hours and 8 min (from any salt enterring to leaving)
[sstar,sstar_soln,p] = fit_inverse_erf(Xebb,Sebb,min(Sebb),xf);
Kx_minsf11pt5hours = 1/(4*(p(1)^2)*(11.5*3600)); % t = 15 hours and 8 min (from any salt enterring to leaving)


figure(19) 
subplot(2,1,1)
plot(Xebb/1000,sstar,'k^'), hold all
plot(Xebb/1000,sstar_mins0,'^','color',[.8 .8 .8]), hold all
plot(Xebb/1000,sstar,'k^'), hold all

plot(xf/1000,sstar_soln,'--')
plot(xf/1000,sstar_soln_0,'-.')

% return;


legend({'S^{*} for S_{min} = 11.6','S^* for S_{min} = 0'},'box','off','location','best')
% return;

ylabel('$S^* = \frac{S - S_{min}}{S_{max}-S_{min}}$','interpreter','latex')

grid on
grid minor
xlabel('X (m)')
title('11 December')



% 
% return;
% 
% 
% 
% 
% figure, plot(Xebb,sstar,'kx'), hold all
% plot(xf,sstar_soln,'r--')
% 
% 
% return;
% 
% minS = 20;
% %minS = min(S);
% So = max(S) -minS; % -min(S);
% 
% lhse0 = 2*(S-minS)/(max(S)-minS) - 1;
% return;
% 
% figure
% % LHSE = (2*Sebb/So  - 1);
% LHSE = (Sebb - minS)*(2/So) - 1;
% subplot(211), plot(Xebb,LHSE,'o')
% ylabel('(Sebb - minS)*(2/So) - 1')
% LHSE = erfinv(LHSE);
% subplot(212), plot(Xebb,LHSE,'o'), hold all
% ylabel('erfinv(LHSE)')
% return;
% 
% LHSE = LHSE(isfinite(Xebb));
% Sebb = Sebb(isfinite(Xebb));
% Xebb = Xebb(isfinite(Xebb));
% 
% 
% Xebb = Xebb(isfinite(LHSE));
% Sebb = Sebb(isfinite(LHSE));
% LHSE = LHSE(isfinite(LHSE));
% %%
% p = polyfit(Xebb,LHSE',1)
% hold all
% xl = xlim;
% plot(xl,p(1)*xl + p(2),'--')
% legend('erf^{-1}(2*Sebb/So - 1)',[num2str(p(1)),'x + ',num2str(p(2))])




function [sstar,sstar_soln,p] = fit_inverse_erf(Xebb,Sebb,minS,xf)
sstar = (Sebb - minS)/(max(Sebb)-minS)
lhse = erfinv(2*sstar/1 - 1);
slhse = size(lhse);
sXebb = size(Xebb);
if slhse(1)~=sXebb(1);
    Xebb = Xebb';
end


p = polyfit(Xebb(isfinite(lhse)),lhse(isfinite(lhse)),1)
sstar_soln = (1/2)*(1+erf(p(1)*xf + p(2)));
end