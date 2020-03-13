% 13 march 2020
% signature_01_plot_sensors.m
% plot pressure, temperature, etc from Signature deployed Maipo Dec 2019
%
% M Williams


clear;
close all

load ../../raw_data/signature/S100882A011_Maipo_Dec_avgd_1.mat
figure(1), plot_temp_pres(Data)
figure(2), 
load ../../raw_data/signature/S100882A011_Maipo_Dec_avgd_2.mat
figure(1), plot_temp_pres(Data)
load ../../raw_data/signature/S100882A011_Maipo_Dec_avgd_3.mat
figure(1), plot_temp_pres(Data)
legend('file avgd\_1','file avgd\_2','file avgd\_3','location','best')


function [] = plot_temp_pres(Data)

subplot(2,1,1), plot(Data.Average_Time,Data.Average_Pressure,'.'), hold all
ylabel('pres. (dbar?)'), grid on
title('Averaged data files - Maipo Signature')
datetick('x')
subplot(2,1,2), plot(Data.Average_Time,Data.Average_Temperature,'.'), hold all
ylabel('T (C)'), grid on
datetick('x')

end
