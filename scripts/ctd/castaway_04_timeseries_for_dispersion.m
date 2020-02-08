clear all;

% close all;



load ../../edited_data/ctd/castaway/castaway_matrices_20191210_maipo.mat




% load ../../edited_data/ctd/castaway/castaway_matrices_20191211_maipo.mat

%%
figure, plot(timevec,rhomatrix(:,5),'.')
hold all
plot(timevec,rhomatrix(:,13),'.')
plot(timevec,rhomatrix(:,17),'.')

figure, plot(timevec,saltmatrix(:,5),'.')
hold all
plot(timevec,saltmatrix(:,13),'.')
plot(timevec,saltmatrix(:,17),'.')

figure
subplot(2,1,1)
plot(timevec,nanmean(saltmatrix,2),'k.')
hold all
plot(timevec,nanmin(saltmatrix'),'.')
plot(timevec,nanmax(saltmatrix'),'.')
legend('mean','min','max')
ylabel('S_A (g/kg)')
title([datestr(timevec(1),'dd mmm yyyy')])
subplot(212)
plot(timevec,nanmax(saltmatrix')-nanmin(saltmatrix'),'.'), ylabel('\Delta S')
datetick2('x')