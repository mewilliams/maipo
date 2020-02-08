% 08 February 2020
% M WIlliams
%
% get the datasets for velocity (LTV) and salinity (castaway) for 10 and 11
% Dec 2019 maipo inlet
% put on same time axis.
%
% first use the interpolated matrix terms
% but later check about the raw downcasts to see if answer differs much



clear
close all;

% load velocity:
load ../../edited_data/adcp/adcp_day2_december_2019_maipo.mat
load ../../edited_data/adcp/adcp_day2_december_2019_maipo_usable.mat
load ../../edited_data/adcp/in_water_indices_rdi_adcp.mat
startidx = startidx_day2;
endidx = endidx_day2;

run('../adcp/adcp_06_moving_avg.m')  % this is sloppy... 

timeadcp = adcp.mtime;
range = cfg.ranges;

inwater = startidx_day2+1000:endidx_day2; % add 1000 - gets rid of lots of spurious data
timeadcp = timeadcp(inwater);
eastvel = eastvel(:,inwater);
northvel = northvel(:,inwater);
vertvel = vertvel(:,inwater);

evconv = evconv(:,inwater);
nvconv = nvconv(:,inwater);
vvconv = vvconv(:,inwater);

figure, 
subplot(211)
pcolor(timeadcp,range,eastvel), shading flat
subplot(212)
pcolor(timeadcp,range,evconv), shading flat


figure, 
% subplot(211)
plot(timeadcp,nanmean(eastvel)), hold all
plot(timeadcp,nanmean(evconv)), hold all
%%

figure, 
% subplot(211)
ix = 2;
plot(timeadcp,eastvel(ix,:)), hold all
plot(timeadcp,evconv(ix,:))
figure
for ix = 1:7
    plot(evconv(ix,:),nvconv(ix,:),'.'), hold all
end
legend('bin 1','bin2','bin3','bin4','bin5','bin6','bin7')

figure
plot(nanmean(evconv,1),nanmean(nvconv,1),'.'), hold all
evconvfinite = nanmean(evconv,1);
nvconvfinite = nanmean(nvconv,1);
nvconvfinite = nvconvfinite(isfinite(evconvfinite));
evconvfinite = evconvfinite(isfinite(evconvfinite));
[ur,vr,thetad] = rotmajax(evconvfinite,nvconvfinite);
plot(ur,vr,'.')


V = -1*(evconv)*sind(thetad) + nvconv*cosd(thetad);
U = evconv*cosd(thetad) + nvconv*sind(thetad);

figure, plot(timeadcp,nanmean(U))


figure
plot(timeadcp,U(1,:))
U81 = U(1,:);
U81finite = interp1(timeadcp(isfinite(U81)),U81(isfinite(U81)),timeadcp);
su81finite = smooth(U81finite,11*60); % smoothed U
X = cumtrapz(su81finite);

% load salinity/ctd data
load ../../edited_data/ctd/castaway/castaway_matrices_20191211_maipo.mat


T = timeadcp;
S = interp1(timevec,nanmean(saltmatrix'),T);

% figure, plot(timevec,

XiS = interp1(timeadcp,X,timevec);
%%
figure
plot(XiS,nanmean(saltmatrix'),'o'), hold all
plot(XiS,saltmatrix(:,5),'^')
plot(XiS,saltmatrix(:,11),'s')

figure
plot(XiS,nanmean(tempmatrix'),'o'), hold all
plot(XiS,tempmatrix(:,5),'^')
plot(XiS,tempmatrix(:,11),'s')


