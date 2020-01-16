% 16 january 2020
% m williams
%
% % adcp_02_plot_raw_data_and_sensors.m
%
% this file doesnt save anything, just plots the relevant sensors for the
% two deployments of the adcp on the La Tagua Veloz.

clear
close all

load ../../edited_data/adcp/adcp_day2_december_2019_maipo.mat

% Sensors

sensors_plot(adcp,cfg,2)
datetick2('x') % zooming datetick2.m function, can replace with datetick('x') 

velocities_pcolor(adcp,cfg,20)
datetick2('x')

echo_intensity_pcolor(adcp,cfg,21)
datetick2('x')

pctgood_pcolor(adcp,cfg,22)
datetick2('x')





load ../../edited_data/adcp/adcp_day1_december_2019_maipo.mat

% Sensors

sensors_plot(adcp,cfg,1)
datetick2('x') % zooming datetick2.m function, can replace with datetick('x') 

velocities_pcolor(adcp,cfg,10)
datetick2('x')

echo_intensity_pcolor(adcp,cfg,11)
datetick2('x')

pctgood_pcolor(adcp,cfg,12)
datetick2('x')

function [] = echo_intensity_pcolor(adcp,cfg,figure_number)
figure(figure_number)
subplot(511), pcolor(adcp.mtime,cfg.ranges,squeeze(adcp.intens(:,1,:))), shading flat, cbax = colorbar;
ylabel(cbax,'EA 1')
subplot(512), pcolor(adcp.mtime,cfg.ranges,squeeze(adcp.intens(:,2,:))), shading flat, cbax = colorbar;
ylabel(cbax,'EA 2')
subplot(513), pcolor(adcp.mtime,cfg.ranges,squeeze(adcp.intens(:,3,:))), shading flat, cbax = colorbar;
ylabel(cbax,'EA 3')
subplot(514), pcolor(adcp.mtime,cfg.ranges,squeeze(adcp.intens(:,4,:))), shading flat, cbax = colorbar;
ylabel(cbax,'EA 4')

subplot(515), pcolor(adcp.mtime,cfg.ranges,squeeze(nanmean(adcp.intens,2))), shading flat, cbax = colorbar;
ylabel(cbax,'Avg. EA')

for i=1:5
    subplot(5,1,i)
    grid on
    ylabel('z (m)')
end

% figure(figure_n/umber)

end



function [] = pctgood_pcolor(adcp,cfg,figure_number)
figure(figure_number)
subplot(511), pcolor(adcp.mtime,cfg.ranges,squeeze(adcp.perc_good(:,1,:))), shading flat, cbax = colorbar;
ylabel(cbax,'% good 1'), caxis([0 100])
subplot(512), pcolor(adcp.mtime,cfg.ranges,squeeze(adcp.perc_good(:,2,:))), shading flat, cbax = colorbar;
ylabel(cbax,'% good 2'), caxis([0 100])
subplot(513), pcolor(adcp.mtime,cfg.ranges,squeeze(adcp.perc_good(:,3,:))), shading flat, cbax = colorbar;
ylabel(cbax,'% good 3'), caxis([0 100])
subplot(514), pcolor(adcp.mtime,cfg.ranges,squeeze(adcp.perc_good(:,4,:))), shading flat, cbax = colorbar;
ylabel(cbax,'% good 4'), caxis([0 100])

subplot(515), pcolor(adcp.mtime,cfg.ranges,squeeze(nanmean(adcp.perc_good,2))), shading flat, cbax = colorbar;
ylabel(cbax,'Avg. % good'), caxis([0 100])

for i=1:5
    subplot(5,1,i)
    grid on
    ylabel('z (m)')
end

% figure(figure_n/umber)

end




function [] = velocities_pcolor(adcp,cfg,figure_number)
figure(figure_number)
subplot(411), pcolor(adcp.mtime,cfg.ranges,adcp.east_vel), shading flat, cbax = colorbar;
ylabel(cbax,'East Vel. (m/s)'), caxis([-1 1])
subplot(412), pcolor(adcp.mtime,cfg.ranges,adcp.north_vel), shading flat, cbax = colorbar;
ylabel(cbax,'North Vel. (m/s)'), caxis([-1 1])
subplot(413), pcolor(adcp.mtime,cfg.ranges,adcp.vert_vel), shading flat, cbax = colorbar;
ylabel(cbax,'Vert. Vel. (m/s)'), caxis([-1 1])
subplot(414), pcolor(adcp.mtime,cfg.ranges,adcp.error_vel), shading flat, cbax = colorbar;
ylabel(cbax,'Error Vel. (m/s)'), caxis([-1 1])

for i=1:4
    subplot(4,1,i)
    grid on
    ylabel('z (m)')
end

end

function [] = sensors_plot(adcp,cfg,figure_number)
figure(figure_number)

subplot(511), plot(adcp.mtime,adcp.pitch), ylabel('pitch (deg)')
subplot(512), plot(adcp.mtime,adcp.roll), ylabel('roll (deg)')
subplot(513), plot(adcp.mtime,adcp.heading), ylabel('heading (deg)')
subplot(514), plot(adcp.mtime,adcp.pressure), ylabel('pressure (units?)')
subplot(515), plot(adcp.mtime,adcp.temperature), ylabel('temperature (C)')
xl = xlim; datelabel1 = datestr(xl(1)); datelabel2 = datestr(xl(2));
xlabel([datelabel1(1:12),'to ',datelabel2(1:12)])

for i = 1:5
    subplot(5,1,i)
    grid on
    set(gca,'tickdir','out')
end

end






