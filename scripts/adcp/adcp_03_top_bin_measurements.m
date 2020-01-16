% 16 january 2020
% m williams
%
% % adcp_03_top_bin_measurements
%
% next step is to find the range of usable velocities, but that will
% require some thinking, so a side-step is to look just at the first bin.

clear
close all

load ../../edited_data/adcp/adcp_day2_december_2019_maipo.mat
figure(2)
plot_N_bin(adcp,cfg,1)
hold all
plot_N_bin_smooth(adcp,cfg,1,10)
datetick2('x')

load ../../edited_data/adcp/adcp_day1_december_2019_maipo.mat
figure(1)
plot_N_bin(adcp,cfg,1)
plot_N_bin_smooth(adcp,cfg,1,10)
datetick2('x')

% data approx 26541:40803

function [] = plot_N_bin(adcp,cfg,bin_number_N)
ax(1) = subplot(411), plot(adcp.mtime,adcp.east_vel(bin_number_N,:)), hold all
ax(2) = subplot(412), plot(adcp.mtime,adcp.north_vel(bin_number_N,:)), hold all
ax(3) = subplot(413), plot(adcp.mtime,adcp.vert_vel(bin_number_N,:)), hold all
ax(4) = subplot(414), plot(adcp.mtime,adcp.error_vel(bin_number_N,:)), hold all
linkaxes(ax,'y') % because datetick2 will link x axes. might break linkaxes though
end


function [] = plot_N_bin_smooth(adcp,cfg,bin_number_N,number_points_to_avg)
ax(1) = subplot(411), plot(adcp.mtime,smooth(adcp.east_vel(bin_number_N,:),number_points_to_avg))
ax(2) = subplot(412), plot(adcp.mtime,smooth(adcp.north_vel(bin_number_N,:),number_points_to_avg))
ax(3) = subplot(413), plot(adcp.mtime,smooth(adcp.vert_vel(bin_number_N,:),number_points_to_avg))
ax(4) = subplot(414), plot(adcp.mtime,smooth(adcp.error_vel(bin_number_N,:),number_points_to_avg))
linkaxes(ax,'y') % because datetick2 will link x axes. might break linkaxes though
end