% adcp_06_moving_avg.m
%
% this file doesn't run standalone. Where does 'eastvel', 'northvel', etc.
%  come from? (m.w. 8 july 2020)
% seems you have to load ../../edited_data/adcp/adcp_day1_december_2019_maipo_usable.mat
% or ../../edited_data/adcp/adcp_day2_december_2019_maipo_usable.mat
% last updated 8 july 2020 m williams
%

%% Added so it will run (8 july 2020):
% Ooof.. from dispersion_01_get_U_S_timeseries:
clear
close all;

% load velocity:
load ../../edited_data/adcp/adcp_day2_december_2019_maipo.mat
load ../../edited_data/adcp/adcp_day2_december_2019_maipo_usable.mat
load ../../edited_data/adcp/in_water_indices_rdi_adcp.mat
startidx = startidx_day2;
endidx = endidx_day2;

mov_avg_samples = 10; 

[evconv,nvconv,vvconv] = run_convolution_adcp_data(eastvel,northvel,vertvel,startidx,endidx,adcp,cfg,mov_avg_samples);

save('../../edited_data/adcp/adcp_day2_mov_avg10.mat','*conv')

load ../../edited_data/adcp/adcp_day1_december_2019_maipo.mat
load ../../edited_data/adcp/adcp_day1_december_2019_maipo_usable.mat
startidx = startidx_day1;
endidx = endidx_day1;
[evconv,nvconv,vvconv] = run_convolution_adcp_data(eastvel,northvel,vertvel,startidx,endidx,adcp,cfg,mov_avg_samples);
save('../../edited_data/adcp/adcp_day1_mov_avg10.mat','*conv')


% made (ugly) function july 8 2020: 
function [evconv,nvconv,vvconv] = run_convolution_adcp_data(eastvel,northvel,vertvel,startidx,endidx,adcp,cfg,mov_avg_samples)

%
k = ones(mov_avg_samples,1);
k = k./sum(k);
sum(k)
evconv = NaN(size(eastvel));
nvconv = NaN(size(eastvel));
vvconv = NaN(size(eastvel));
for j = 1:19
evconv(j,:) = conv(eastvel(j,:),k,'same');
nvconv(j,:) = conv(northvel(j,:),k,'same');
vvconv(j,:) = conv(vertvel(j,:),k,'same');
end

evconv(:,1:startidx) = NaN;
evconv(:,endidx:end) = NaN;
nvconv(:,1:startidx) = NaN;
nvconv(:,endidx:end) = NaN;
vvconv(:,1:startidx) = NaN;
vvconv(:,endidx:end) = NaN;

figure
subplot(311)
pcolor(adcp.mtime,cfg.ranges,evconv), shading flat, title('conv east'), colorbar

subplot(312)
pcolor(adcp.mtime,cfg.ranges,nvconv), shading flat,title('conv north'), colorbar

subplot(313)
pcolor(adcp.mtime,cfg.ranges,vvconv), shading flat, title('conv vert'), colorbar


%% 
% sanity check the moving average is ok:
figure
subplot(211)
plot(adcp.mtime,eastvel(1,:)), hold all
plot(adcp.mtime,conv(eastvel(1,:),k,'same'))
plot(adcp.mtime,evconv(1,:))
subplot(212) 
plot(adcp.mtime, conv(eastvel(1,:),k,'same') - evconv(1,:))

% plot(adcp.mtime,evconv(1,:))

%%
% OUTLIERS??
figure
plot(evconv(1,:),nvconv(1,:),'k.')
xlabel('east vel'), ylabel('north vel')
hold all
% plot(evconv(2,:),nvconv(2,:),'r.')


figure
subplot(211)
plot(adcp.mtime,evconv(1,:),'.')
ylabel('east vel')
subplot(212)
plot(adcp.mtime,nvconv(1,:),'.')
ylabel('north vel')
xlabel(datestr(xlim))
datetick2('x')

end
