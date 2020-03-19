% signature_03_plot_burst_velocities.m
% 19 march 2020
% m williams
%
% plot burst velocities from Maipo deployement.
% 5th beam and 4 beams...
clear; 
close all

load ../../raw_data/signature/S100882A011_Maipo_Dec_1.mat

plot_bin1_4beam(Data);

figure

function [] = plot_bin1_4beam(Data)
subplot(4,1,1), plot(Data.Alt_Burst_Time,Data.Alt_Burst_VelBeam1(:,1))
title('beam 1')
subplot(4,1,2), plot(Data.Alt_Burst_Time,Data.Alt_Burst_VelBeam2(:,1)), title('beam 2')

subplot(4,1,3), plot(Data.Alt_Burst_Time,Data.Alt_Burst_VelBeam3(:,1)), title('beam 3')

subplot(4,1,4), plot(Data.Alt_Burst_Time,Data.Alt_Burst_VelBeam4(:,1)), title('beam 4')

end

