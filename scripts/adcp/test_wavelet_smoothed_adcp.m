% 08 july 2020
% quick wavelet test of RDI adcp data
%

clear
close all;
load ../../edited_data/adcp/adcp_day1_mov_avg10.mat
load ../../edited_data/adcp/adcp_day1_december_2019_maipo.mat


disp('check these are one second apart:')
disp(datestr(adcp.mtime(1:10))) 


ev1 = evconv(1,:);
figure, plot(ev1)

i1 = find(isfinite(ev1),1,'first')
i2 = find(isfinite(ev1),1,'last')

ev1 = ev1(i1:i2);
t1 = adcp.mtime(i1:i2);

%%
% for day 2
firstnanidx = 4827;
lastnanidx = 21644;

% for day 1:
lastnanidx = 21644;

%

ev_nonand1 = interp1(t1(isfinite(ev1)),ev1(isfinite(ev1)),t1);



fs = 1;
%%
[wtnn1,f1nn1,coinn1] = cwt(ev_nonand1,fs);
pcolor(t1,f1nn1,abs(wtnn1)), shading flat
hold all
plot(t1,coinn1,'w')



%%


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



%%
%interpolate to extend a bit. 

ev_nonan = interp1(t1(isfinite(ev1)),ev1(isfinite(ev1)),t1);

% by inspection, sort of OK to 
firstnanidx2 = 10440;
lastnanidx2 = 16000;



[wt,f1,coi] = cwt(ev_nonan(lastnanidx2+1:end),fs);

figure(19)
subplot(2,1,1)

pcolor(t1(lastnanidx2+1:end),f1,abs(wt)), shading flat
hold all
ylabel('frequency [hz]')
colorbar
disp(caxis)
ca = [0 0.05];
caxis(ca)
set(gca,'yscale','log')
hold all
plot(t1(lastnanidx2+1:end),coi,'w','linewidth',2)
plot(xlim,ones(2,1)*(1/30),'w--','linewidth',2)
plot(xlim,ones(2,1)*(1/300),'w--','linewidth',2)
plot(xlim,ones(2,1)*(1/(12.42*3600)),'c--','linewidth',2)
xlim([t1(lastnanidx2+1) t1(end)])
datetick('x','keeplimits')


[wt,f1,coi] = cwt(ev_nonan(1:firstnanidx2-1),fs);

% figure(19)
% subplot(2,1,1)
pcolor(t1(1:firstnanidx2-1),f1,abs(wt)), shading flat
ylabel('frequency [hz]')
colorbar
disp(caxis)
ca = [0 0.05];
caxis(ca)
set(gca,'yscale','log')
hold all
plot(t1(1:firstnanidx2-1),coi,'w','linewidth',2)
plot(xlim,ones(2,1)*(1/30),'w--','linewidth',2)
plot(xlim,ones(2,1)*(1/300),'w--','linewidth',2)
plot(xlim,ones(2,1)*(1/(12.42*3600)),'c--','linewidth',2)
xlim([t1(1) t1(firstnanidx2-1)])
datetick2('x','keeplimits')

subplot(2,1,2)
plot(t1,ev_nonan), ylabel('bin 1 east vel')
datetick2('x')
