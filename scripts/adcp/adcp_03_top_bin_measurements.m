% 16 january 2020
% m williams
%
% % adcp_03_top_bin_measurements
%
% next step is to find the range of usable velocities, but that will
% require some thinking, so a side-step is to look just at the first bin.

clear
close all

load ../../edited_data/adcp/in_water_indices_rdi_adcp.mat

load ../../edited_data/adcp/adcp_day2_december_2019_maipo.mat
figure(2)
plot_N_bin(adcp,cfg,1)
hold all
plot_N_bin_smooth(adcp,cfg,1,10)
datetick2('x')

figure(20)
plot_N_bin(adcp,cfg,1,startidx_day2,startidx_day2)
plot_N_bin_smooth(adcp,cfg,1,10,startidx_day2,endidx_day2)
datetick2('x')
title('day 2 - 11 Dec 2019')

binno = 1;
figure(299)
plot(adcp.east_vel(binno,startidx_day2:endidx_day2),adcp.north_vel(binno,(startidx_day2:endidx_day2)),'.')
axis equal
grid on
xlabel(['East Vel, bin ',num2str(binno)])
ylabel(['North Vel, bin ',num2str(binno)])
title(['Day 2, bin ',num2str(binno)])
axis equal

figure(399)
plot(adcp.east_vel(binno,startidx_day2:endidx_day2),adcp.north_vel(binno,(startidx_day2:endidx_day2)),'.')
hold all
axis equal
grid on
xlabel(['East Vel, bin ',num2str(binno)])
ylabel(['North Vel, bin ',num2str(binno)])

% return;

load ../../edited_data/adcp/adcp_day1_december_2019_maipo.mat
figure(1)
plot_N_bin(adcp,cfg,1)
plot_N_bin_smooth(adcp,cfg,1,10)
datetick2('x')

figure(10)
plot_N_bin(adcp,cfg,1,startidx_day1,endidx_day1)
plot_N_bin_smooth(adcp,cfg,1,10,startidx_day1,endidx_day1)
datetick2('x')
title('day 1 - 10 Dec 2019')


figure(199)

plot(adcp.east_vel(binno,(startidx_day1:endidx_day1)),adcp.north_vel(binno,(startidx_day1:endidx_day1)),'.')
axis equal
grid on
xlabel(['East Vel, bin ',num2str(binno)])
ylabel(['North Vel, bin ',num2str(binno)])
title(['Day 1, bin ',num2str(binno)])
axis equal


figure(399)
plot(adcp.east_vel(binno,(startidx_day1:endidx_day1)),adcp.north_vel(binno,(startidx_day1:endidx_day1)),'.')
hold all
legend('day 2','day 1')
axis equal 

% data approx 26541:40803

function [] = plot_N_bin(adcp,cfg,bin_number_N,startidx,endidx)
switch nargin
    case 3
        ax(1) = subplot(411), plot(adcp.mtime,adcp.east_vel(bin_number_N,:)), hold all
        ax(2) = subplot(412), plot(adcp.mtime,adcp.north_vel(bin_number_N,:)), hold all
        ax(3) = subplot(413), plot(adcp.mtime,adcp.vert_vel(bin_number_N,:)), hold all
        ax(4) = subplot(414), plot(adcp.mtime,adcp.error_vel(bin_number_N,:)), hold all
        linkaxes(ax,'y') % because datetick2 will link x axes. might break linkaxes though
    case 5
        ax(1) = subplot(411), plot(adcp.mtime(startidx:endidx),adcp.east_vel(bin_number_N,(startidx:endidx))), hold all
        ax(2) = subplot(412), plot(adcp.mtime(startidx:endidx),adcp.north_vel(bin_number_N,(startidx:endidx))), hold all
        ax(3) = subplot(413), plot(adcp.mtime(startidx:endidx),adcp.vert_vel(bin_number_N,(startidx:endidx))), hold all
        ax(4) = subplot(414), plot(adcp.mtime(startidx:endidx),adcp.error_vel(bin_number_N,(startidx:endidx))), hold all
        linkaxes(ax,'y') % because datetick2 will link x axes. might break linkaxes though
        
        
    otherwise
        disp('wrong number of inputs to funcion plot_N_bin')
end
end


function [] = plot_N_bin_smooth(adcp,cfg,bin_number_N,number_points_to_avg,startidx,endidx)
switch nargin
    case 4
        ax(1) = subplot(411), plot(adcp.mtime,smooth(adcp.east_vel(bin_number_N,:),number_points_to_avg))
        ax(2) = subplot(412), plot(adcp.mtime,smooth(adcp.north_vel(bin_number_N,:),number_points_to_avg))
        ax(3) = subplot(413), plot(adcp.mtime,smooth(adcp.vert_vel(bin_number_N,:),number_points_to_avg))
        ax(4) = subplot(414), plot(adcp.mtime,smooth(adcp.error_vel(bin_number_N,:),number_points_to_avg))
        linkaxes(ax,'y') % because datetick2 will link x axes. might break linkaxes  6though
    case 6
         ax(1) = subplot(411), plot(adcp.mtime(startidx:endidx),smooth(adcp.east_vel(bin_number_N,startidx:endidx),number_points_to_avg))
        ax(2) = subplot(412), plot(adcp.mtime(startidx:endidx),smooth(adcp.north_vel(bin_number_N,startidx:endidx),number_points_to_avg))
        ax(3) = subplot(413), plot(adcp.mtime(startidx:endidx),smooth(adcp.vert_vel(bin_number_N,startidx:endidx),number_points_to_avg))
        ax(4) = subplot(414), plot(adcp.mtime(startidx:endidx),smooth(adcp.error_vel(bin_number_N,startidx:endidx),number_points_to_avg))
        linkaxes(ax,'y') % because datetick2 will link x axes. might break linkaxes  6though

    otherwise
        disp('wrong number of inputs to funcion plot_N_bin_smooth')
end


end