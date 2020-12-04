% quick_wavelet_maipo_pressure.m

% clear
% close all
% input('clear data? ','s')
disp('quick wavelet maipo pressure')
disp('does not clear workspace or images right now.')

% requires quick_plot_rbr_pressure_sensor.m for the following data file.
load ../../edited_data/rbr/two_pressure_records_raw.mat

inwater1 = 348461:3002915; %by inspection
inwater2 = 537015:4698078;

save('../../edited_data/rbr/indices_in_water','inwater*')

p1 = p1(inwater1);
t1 = t1(inwater1);
 
p2 = p2(inwater2);
t2 = t2(inwater2);





%%
fs = 16; % sampling frequency in hz

% rough subsample to 0.5 Hz:
F_SUBSAMPLE = .25
N = fs/F_SUBSAMPLE;
idx = 1:N:length(t1);

% return;

tic
[wt1,f1,coi] = cwt(p1(idx),F_SUBSAMPLE);
toc

idx2 = 1:N:length(t2);

tic
[wt2,f2,coi2] = cwt(p2(idx2),F_SUBSAMPLE);
toc

disp(size(wt1))

ca =[0 .05];


%%
figure
ax(1) = subplot(3,1,1:2)

pcolor(t2(idx2),f2,abs(wt2)), shading flat
ylabel('frequency [hz]')
colorbar
disp(caxis)
caxis(ca)
set(gca,'yscale','log')
hold all
plot(t2(idx2),coi2,'w','linewidth',2)
plot(xlim,ones(2,1)*(1/30),'w--','linewidth',2)
plot(xlim,ones(2,1)*(1/300),'w--','linewidth',2)
plot(xlim,ones(2,1)*(1/(12.42*3600)),'c--','linewidth',2)

datetick('x')


ax(2) = subplot(3,1,3)
plot(t2,p2), grid on
ylabel('pres. [dbar]')
datetick('x')
%%
figure
ax2(1) = subplot(3,1,1:2)
pcolor(t1(idx),f1,abs(wt1)), shading flat
ylabel('frequency [hz]')
colorbar
disp(caxis)
caxis(ca)
set(gca,'yscale','log')
hold all
% plot(t1(idx),coi,'w','linewidth',2)
plot(xlim,ones(2,1)*(1/30),'w--','linewidth',2)
plot(xlim,ones(2,1)*(1/300),'w--','linewidth',2)

% fill a polygon over the COI:
fillT = t1(idx);
fillT(2:end+1) = fillT;
fillT(end+1) = fillT(end);

fillcoi = coi;
fillcoi(2:end+1) = fillcoi;
fillcoi(1) = min(coi); % not zero because axis is log
fillcoi(end+1) = min(coi);
fill(fillT,fillcoi,'k')

datetick('x')

ax2(2) = subplot(3,1,3)
plot(t1,p1), grid on
ylabel('pres. [dbar]')
datetick('x')
colorbar
