% 24 nov 2020
% m williams

close all;
clear

load ../../edited_data/adcp/adcp_day1_december_2019_maipo.mat
load ../../edited_data/adcp/adcp_day1_mov_avg10.mat

figure, plot(evconv(1,:),nvconv(1,:),'.')
hold all
plot(evconv(2,:),nvconv(2,:),'.')
plot(evconv(3,:),nvconv(3,:),'.')
plot(evconv(4,:),nvconv(4,:),'.')
legend('bin 1','2','3','4')
axis equal, grid on

xlabel('east vel (10-s mov. avg.) [m/s]')
ylabel('north vel (10-s mov. avg.) [m/s]')

figure, plot(adcp.mtime,evconv(1,:))
hold all

ix = find(adcp.mtime<datenum(2019,12,10,19,30,0));
evconv(:,ix) = NaN;
nvconv(:,ix) = NaN;
vvconv(:,ix) = NaN;

plot(adcp.mtime,evconv(1,:))

figure, plot(evconv(1,:),nvconv(1,:),'.')
hold all
plot(evconv(2,:),nvconv(2,:),'.')
plot(evconv(3,:),nvconv(3,:),'.')
plot(evconv(4,:),nvconv(4,:),'.')
legend('bin 1','2','3','4')

figure, subplot(211), pcolor(adcp.mtime,cfg.ranges,evconv), shading flat
subplot(212), pcolor(adcp.mtime,cfg.ranges,nvconv), shading flat

%%

%just use 1st cell for analysis, rotation, etc.:
ixfin = find(isfinite(evconv(1,:)));
[ur,vr,thetarot] = rotmajax(evconv(1,ixfin),nvconv(1,ixfin));
clear ur vr
% ur_10ma 

V_10ma = -1*(evconv(1,:))*sind(thetarot) + nvconv(1,:)*cosd(thetarot);
U_10ma = evconv(1,:)*cosd(thetarot) + nvconv(1,:)*sind(thetarot);



%%

figure, 
subplot(1,2,1), plot(adcp.mtime,evconv(1,:), adcp.mtime, nvconv(1,:))
legend('east vel. bin 1','north vel. bin 1','location','best')
title('Earth coords. ')
grid on
ylim([-1.5 2])
% axis equal
subplot(1,2,2), plot(adcp.mtime,U_10ma, adcp.mtime, V_10ma)
legend('U rotated principle flow direction','V rotated','location','best')
title(['Rotation through angle \theta = ',num2str(thetarot)])
% axis equal
grid on
ylim([-1.5 2])

datetick2('x')

%%

figure, plot(adcp.mtime,U_10ma)
disp('filling in some nans')
ix1 = find(isfinite(U_10ma),1,'first')
ixend = find(isfinite(U_10ma),1,'last')

U_fill10ma = interp1(adcp.mtime(isfinite(U_10ma)),U_10ma(isfinite(U_10ma)),adcp.mtime(ix1:ixend))
timefill = adcp.mtime(ix1:ixend);
plot(timefill,U_fill10ma,'linewidth',2), hold all
plot(adcp.mtime,U_10ma,'linewidth',2)
xlabel('10 Dec 2019')
ylabel('Velocity [m/s]')
legend('FILLED U data','data with NaNs')
datetick2('x')

%% IG - try a 10-min. moving average to separate..? 

k = ones(600,1);
k = k./sum(k);
U_10min = conv(U_fill10ma,k,'same')
figure, plot(timefill,U_10min,timefill,U_fill10ma)


k = ones(15*60,1);
k = k./sum(k);
U_15min = conv(U_fill10ma,k,'same')
hold all
plot(timefill,U_15min)

U_15minsmooth = smooth(U_fill10ma,15*60);
figure
plot(timefill,U_15minsmooth), hold all
plot(timefill,U_15min)

figure
subplot(211)
plot(timefill,U_fill10ma,'k'), legend('U, 10-s moving avg')
subplot(212)
plot(timefill,U_15minsmooth,'linewidth',2), hold all
plot(timefill,U_fill10ma-U_15minsmooth)
legend('U, 15-min. moving avg','IG component (mov. avg. removed)')


%%

clear all

load ../../edited_data/adcp/adcp_day2_december_2019_maipo.mat
load ../../edited_data/adcp/adcp_day2_mov_avg10.mat


figure, plot(evconv(1,:),nvconv(1,:),'.')
hold all
plot(evconv(2,:),nvconv(2,:),'.')
plot(evconv(3,:),nvconv(3,:),'.')
plot(evconv(4,:),nvconv(4,:),'.')
legend('bin 1','2','3','4')



figure, subplot(211), pcolor(adcp.mtime,cfg.ranges,evconv), shading flat
subplot(212), pcolor(adcp.mtime,cfg.ranges,nvconv), shading flat