% plot_pressure_sensor_OS_poster.m
% m williams
% 9 feb 2020

load ../../edited_data/rbr/two_pressure_records_raw.mat
load ../../edited_data/rbr/indices_in_water

p1 = p1(inwater1);
t1 = t1(inwater1);

plot(t1,p1), hold all
plot(t1,smooth(p1,16*5*60))
ylabel('Pressure (dbar)')
title('Inlet bed pressure sensor')
grid on
grid minor
