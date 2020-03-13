% 13 march 2020
% signature_01_plot_sensors.m
% plot pressure, temperature, etc from Signature deployed Maipo Dec 2019
%
% M Williams


clear;
close all

disp('file does not save anything, just makes some plots')


% SPLIT 1 
load ../../raw_data/signature/S100882A011_Maipo_Dec_avgd_1.mat
figure(1), plot_temp_pres(Data)
figure(2), plot_pitch_roll_batt(Data)

% SPLIT 2 
load ../../raw_data/signature/S100882A011_Maipo_Dec_avgd_2.mat
figure(1), plot_temp_pres(Data)
figure(2), plot_pitch_roll_batt(Data)

% SPLIT 3 (out of water)
load ../../raw_data/signature/S100882A011_Maipo_Dec_avgd_3.mat
figure(1), plot_temp_pres(Data)
legend('file avgd\_1','file avgd\_2','file avgd\_3','location','best')

figure(2), plot_pitch_roll_batt(Data)
legend('file avgd\_1','file avgd\_2','file avgd\_3','location','best')


function [] = plot_temp_pres(Data)

subplot(2,1,1), plot(Data.Average_Time,Data.Average_Pressure,'.'), hold all
ylabel('pres. (dbar)'), grid on
title('Averaged data files - Maipo Signature')
datetick('x')
subplot(2,1,2), plot(Data.Average_Time,Data.Average_Temperature,'.'), hold all
ylabel('T (C)'), grid on
datetick('x')

end

function [] = plot_pitch_roll_batt(Data)

subplot(4,1,1), plot(Data.Average_Time,Data.Average_Pitch,'.'), hold all
ylabel('Pitch (°)'), grid on
title('Averaged data files - Maipo Signature')
datetick('x')

subplot(4,1,2), plot(Data.Average_Time,Data.Average_Roll,'.'), hold all
ylabel('Roll (°)'), grid on
datetick('x')


subplot(4,1,3), plot(Data.Average_Time,Data.Average_Heading,'.'), hold all
ylabel('Header (°)'), grid on
datetick('x')

subplot(4,1,4), plot(Data.Average_Time,Data.Average_Battery,'.'), hold all
ylabel('Battery (V)'), grid on
datetick('x')
end
