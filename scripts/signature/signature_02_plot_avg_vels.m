% 13 march 2020
% signature_02_plot_avg_vels.m
% plot average velocity, echo amplitude, etc. from maipo
%
% M Williams


clear;
close all

disp('file does not save anything, just makes some plots')


% SPLIT 1 
load ../../raw_data/signature/S100882A011_Maipo_Dec_avgd_1.mat
figure(1), pcolor_avg_vels(Data)
figure(2), plot_pitch_roll_batt(Data)

% SPLIT 2 
load ../../raw_data/signature/S100882A011_Maipo_Dec_avgd_2.mat
figure(1), pcolor_avg_vels(Data)
figure(2), plot_pitch_roll_batt(Data)

% SPLIT 3 (out of water)
load ../../raw_data/signature/S100882A011_Maipo_Dec_avgd_3.mat
figure(1), pcolor_avg_vels(Data)
legend('file avgd\_1','file avgd\_2','file avgd\_3','location','best')

figure(2), plot_pitch_roll_batt(Data)
legend('file avgd\_1','file avgd\_2','file avgd\_3','location','best')


function [] = pcolor_avg_vels(Data)

subplot(4,1,1), pcolor(Data.Average_VelEast), shading flat, datetick('x')
title('Averaged data files - Maipo Signature')
cbax = colorbar, ylabel(cbax,'East Vel (m/s)')
subplot(4,1,2), pcolor(Data.Average_VelNorth), shading flat, datetick('x')
cbax = colorbar, ylabel(cbax,'North Vel (m/s)')

subplot(4,1,3), pcolor(Data.Average_VelUp1), shading flat, datetick('x')
cbax = colorbar, ylabel(cbax,'Vert Vel 1 (m/s)')

subplot(4,1,4), pcolor(Data.Average_VelUp2), shading flat, datetick('x')
cbax = colorbar, ylabel(cbax,'Vert Vel 2 (m/s)')



end

function [] = pcolor_avg_beamamp(Data)

subplot(4,1,1), pcolor(Data.Average_AmpBeam1), shading flat, datetick('x')
title('Averaged data files - Maipo Signature')
cbax = colorbar, ylabel(cbax,'Amp. beam 1')
subplot(4,1,2), pcolor(Data.Average_AmpBeam2), shading flat, datetick('x')
cbax = colorbar, ylabel(cbax,'North Vel (m/s)')

subplot(4,1,3), pcolor(Data.Average_AmpBeam3), shading flat, datetick('x')
cbax = colorbar, ylabel(cbax,'Vert Vel 1 (m/s)')

subplot(4,1,4), pcolor(Data.Average_AmpBeam4), shading flat, datetick('x')
cbax = colorbar, ylabel(cbax,'Vert Vel 2 (m/s)')



end