% quick_wavelet_maipo_pressure.m

clear
close all

load ../../edited_data/rbr/two_pressure_records_raw.mat

fs = 16; % sampling frequency in hz
[wt1
    

,f1] = cwt(p1,fs);