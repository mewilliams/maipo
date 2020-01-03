% quick_wavelet_maipo_pressure.m

clear
close all

% requires quick_plot_rbr_pressure_sensor.m for the following data file.
load ../../edited_data/rbr/two_pressure_records_raw.mat

inwater1 = 348461:3002915; %by inspection

p1 = p1(inwater1);
t1 = t1(inwater1);

%%
fs = 16; % sampling frequency in hz
tic
[wt1,f1] = cwt(p1,fs);
toc