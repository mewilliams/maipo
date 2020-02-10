% 10 February 2020
% M Williams

addpath(genpath('~/Research/general_scripts/matlabfunctions/'))

clear all;
% close all;
returnhere = pwd;

cd ../adcp/aqd/
disp('press 1!')
AQD_U_H
cd(returnhere)

tbin_seconds = tbin-min(tbin);
tbin_seconds = tbin_seconds*24*3600;
X = cumtrapz(tbin_seconds,-U);

% if 

% run('../adcp/aqd/AQD_U_H.m')
figure(19)
subplot(311), plot(tbin,-U), hold all
subplot(312), plot(tbin,X), hold all
subplot(313), plot(tbin,Sbin), hold all

save(['../../edited_data/dispersion_analysis/maipo_UXS_aqd_fsi_',num2str(fileno)],'U','X','Sbin','tbin*')


