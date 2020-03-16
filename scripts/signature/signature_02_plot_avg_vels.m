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
figure(1), pcolor_avg_vels(Data,Config)
figure(2), pcolor_avg_beamamp(Data,Config)
figure(3), pcolor_avg_corr(Data,Config)
figure(4), plot_bin1_vels(Data)


% SPLIT 2 
load ../../raw_data/signature/S100882A011_Maipo_Dec_avgd_2.mat
figure(1), pcolor_avg_vels(Data,Config)
figure(2), pcolor_avg_beamamp(Data,Config)
figure(3), pcolor_avg_corr(Data,Config)
figure(4), plot_bin1_vels(Data)

return;

% SPLIT 3 (out of water)
load ../../raw_data/signature/S100882A011_Maipo_Dec_avgd_3.mat
figure(1), pcolor_avg_vels(Data,Config)
figure(2), pcolor_avg_beamamp(Data,Config)
figure(3), pcolor_avg_corr(Data,Config)
figure(4), plot_bin1_vels(Data)

function [] = plot_bin1_vels(Data)
subplot(311), plot(Data.Average_Time,Data.Average_VelEast(:,1)), hold all
legend('bin1 east vel')
ylabel('east vel (m/s)')
datetick('x')

subplot(312), plot(Data.Average_Time,Data.Average_VelNorth(:,1)), hold all
legend('bin1 north vel')
ylabel('north vel (m/s)')
datetick('x')

subplot(313), plot(Data.Average_Time,Data.Average_VelUp1(:,1),'k'), hold all
subplot(313), plot(Data.Average_Time,Data.Average_VelUp2(:,1),'r')
legend('up 1','up 2')
ylabel('vert vel (m/s)')
datetick('x')

end


function [] = pcolor_avg_vels(Data,Config)
N = Data.Average_NCells(1);
N = double(N)

cell_height = [Config.Average_BlankingDistance(1):Config.Average_CellSize(1):N*Config.Average_CellSize(1)];
disp(cell_height)

binno = 1:21;
subplot(4,1,1), pcolor(Data.Average_Time, cell_height,Data.Average_VelEast'), shading flat,  hold all
title('Averaged data files - Maipo Signature')
datetick('x')

cbax = colorbar, ylabel(cbax,'East Vel (m/s)')
subplot(4,1,2),pcolor(Data.Average_Time, cell_height,Data.Average_VelNorth'), shading flat,  hold all
cbax = colorbar, ylabel(cbax,'North Vel (m/s)')
datetick('x')

subplot(4,1,3), pcolor(Data.Average_Time, cell_height,Data.Average_VelUp1'), shading flat, hold all
cbax = colorbar, ylabel(cbax,'Vert Vel 1 (m/s)')
datetick('x')

subplot(4,1,4), pcolor(Data.Average_Time, cell_height,Data.Average_VelUp2'), shading flat,  hold all
cbax = colorbar, ylabel(cbax,'Vert Vel 2 (m/s)')
datetick('x')


end

function [] = pcolor_avg_beamamp(Data,Config)
binno = 1:21;
N = Data.Average_NCells(1);
N = double(N)

cell_height = [Config.Average_BlankingDistance(1):Config.Average_CellSize(1):N*Config.Average_CellSize(1)];
disp(cell_height)

subplot(4,1,1), pcolor(Data.Average_Time, cell_height,Data.Average_AmpBeam1'), shading flat, datetick('x'), hold all
title('Averaged data files - Maipo Signature')
cbax = colorbar, ylabel(cbax,'Amp. beam 1 (dB?)')
subplot(4,1,2), pcolor(Data.Average_Time, cell_height,Data.Average_AmpBeam2'), shading flat, datetick('x'), hold all
cbax = colorbar, ylabel(cbax,'Amp. beam 2 (dB?)')
subplot(4,1,3), pcolor(Data.Average_Time, cell_height,Data.Average_AmpBeam3'), shading flat, datetick('x'), hold all
cbax = colorbar, ylabel(cbax,'Amp. beam 3 (dB?)')

subplot(4,1,4), pcolor(Data.Average_Time, cell_height,Data.Average_AmpBeam4'), shading flat, datetick('x'), hold all
cbax = colorbar, ylabel(cbax,'Amp. beam 4 (dB?)')



end


function [] = pcolor_avg_corr(Data,Config)
binno = 1:21;
N = Data.Average_NCells(1);
N = double(N)

cell_height = [Config.Average_BlankingDistance(1):Config.Average_CellSize(1):N*Config.Average_CellSize(1)];
disp(cell_height)

subplot(4,1,1), pcolor(Data.Average_Time, cell_height,Data.Average_CorBeam1'), shading flat, datetick('x'), hold all
title('Averaged data files - Maipo Signature')
cbax = colorbar, ylabel(cbax,'Cor. beam 1)')
subplot(4,1,2), pcolor(Data.Average_Time, cell_height,Data.Average_CorBeam2'), shading flat, datetick('x'), hold all
cbax = colorbar, ylabel(cbax,'Cor. beam 2')
subplot(4,1,3), pcolor(Data.Average_Time, cell_height,Data.Average_CorBeam3'), shading flat, datetick('x'), hold all
cbax = colorbar, ylabel(cbax,'Cor. beam 3')

subplot(4,1,4), pcolor(Data.Average_Time, cell_height,Data.Average_CorBeam4'), shading flat, datetick('x'), hold all
cbax = colorbar, ylabel(cbax,'Cor. beam 4')



end