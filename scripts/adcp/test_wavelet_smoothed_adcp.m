% 08 july 2020
% quick wavelet test of RDI adcp data
%

clear
close all;
load ../../edited_data/adcp/adcp_day2_mov_avg10.mat
load ../../edited_data/adcp/adcp_day2_december_2019_maipo.mat


disp('check these are one second apart:')
disp(datestr(adcp.mtime(1:10))) 


ev1 = evconv(1,:);
figure, plot(ev1)

i1 = find(isfinite(ev1),1,'first')
i2 = find(isfinite(ev1),1,'last')

ev1 = ev1(i1:i2);
t1 = adcp.mtime(i1:i2);

%%
firstnanidx = 4827;
lastnanidx = 21644;

fs = 1;

[wt,f1,coi] = cwt(ev1(1:firstnanidx-1),fs);

figure
subplot(2,2,1)
pcolor(t1(1:firstnanidx-1),f1,abs(wt)), shading flat
ylabel('frequency [hz]')
colorbar
disp(caxis)
ca = [0 0.05];
caxis(ca)
set(gca,'yscale','log')
hold all
plot(t1(1:firstnanidx-1),coi,'w','linewidth',2)
plot(xlim,ones(2,1)*(1/30),'w--','linewidth',2)
plot(xlim,ones(2,1)*(1/300),'w--','linewidth',2)
plot(xlim,ones(2,1)*(1/(12.42*3600)),'c--','linewidth',2)
xlim([t1(1) t1(firstnanidx-1)])
datetick('x','keeplimits')


%%

[wt,f1,coi] = cwt(ev1(lastnanidx+1:end),fs);

subplot(2,2,2)
pcolor(t1(lastnanidx+1:end),f1,abs(wt)), shading flat
ylabel('frequency [hz]')
colorbar
disp(caxis)
ca = [0 0.05];
caxis(ca)
set(gca,'yscale','log')
hold all
plot(t1(lastnanidx+1:end),coi,'w','linewidth',2)
plot(xlim,ones(2,1)*(1/30),'w--','linewidth',2)
plot(xlim,ones(2,1)*(1/300),'w--','linewidth',2)
plot(xlim,ones(2,1)*(1/(12.42*3600)),'c--','linewidth',2)
xlim([t1(lastnanidx+1) t1(end)])
datetick('x','keeplimits')
%%
subplot(2,2,3)
plot(t1(1:firstnanidx-1),ev1(1:firstnanidx-1))
ylabel('east vel, bin 1')
xlim([t1(1) t1(firstnanidx-1)])
datetick('x','keeplimits')
colorbar
ylim([-.8 1.5])

subplot(2,2,4)
plot(t1(lastnanidx+1:end),ev1(lastnanidx+1:end))
ylabel('east vel, bin 1')
colorbar
ylim([-.8 1.5])

xlim([t1(lastnanidx+1) t1(end)])
datetick('x','keeplimits')
colorbar
% datetick2('x')