function [] = plot_N_bin(adcp,cfg,bin_number_N,startidx,endidx)
% [] = plot_N_bin(adcp,cfg,bin_number_N,startidx,endidx);
% startidx and endidx are optional. If not input, will plot the entire
% timerseries.
% written originally in adcp_03_top_bin_measurements.m, but I wanted it
% universally available, I think. For the time being function
% plot_N_bin_smooth is still in the adcp_03... script. 
% 
% m. williams
% 29 January 2020
%
%

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
