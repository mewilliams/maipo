% signature_03_plot_burst_velocities.m
% 19 march 2020
% m williams
%
% plot burst velocities from Maipo deployement.
% 5th beam and 4 beams...

addpath(genpath('~/Research/general_scripts/matlabfunctions/'))

clear;
% close all

load ../../raw_data/signature/S100882A011_Maipo_Dec_1.mat
% [idx_burst] = burst_indices(Data.Alt_Burst_Time);

figure(1)
plot_bin1_4beam(Data);

figure(2)
pcolor_vel_burst_by_burst(Data)



figure(13)
subplot(4,1,1)
pcolor_alt_burst_anything(Data.Alt_Burst_AmpBeam1,Data), shading flat
subplot(4,1,2)
pcolor_alt_burst_anything(Data.Alt_Burst_AmpBeam2,Data), shading flat
subplot(4,1,3)
pcolor_alt_burst_anything(Data.Alt_Burst_AmpBeam3,Data), shading flat
subplot(4,1,4)
pcolor_alt_burst_anything(Data.Alt_Burst_AmpBeam4,Data), shading flat
datetick2('x')

load ../../raw_data/signature/S100882A011_Maipo_Dec_2.mat
% [idx_burst] = burst_indices(Data.Alt_Burst_Time);


figure(13)
subplot(4,1,1)
pcolor_alt_burst_anything(Data.Alt_Burst_AmpBeam1,Data), shading flat
subplot(4,1,2)
pcolor_alt_burst_anything(Data.Alt_Burst_AmpBeam2,Data), shading flat
subplot(4,1,3)
pcolor_alt_burst_anything(Data.Alt_Burst_AmpBeam3,Data), shading flat
subplot(4,1,4)
pcolor_alt_burst_anything(Data.Alt_Burst_AmpBeam4,Data), shading flat
datetick2('x')

figure(1)
plot_bin1_4beam(Data);
datetick2('x')

figure(2)
colormap(cbrewer('div','RdYlBu',16))

pcolor_vel_burst_by_burst(Data)
datetick2('x')
for i= 1:4
    subplot(4,1,i)
    caxis([-.5 .5])
    colorbar
end
% figure


figure(13)

subplot(4,1,1)
pcolor_alt_burst_anything(Data.Alt_Burst_AmpBeam1,Data), shading flat

subplot(4,1,2)
pcolor_alt_burst_anything(Data.Alt_Burst_AmpBeam2,Data), shading flat

subplot(4,1,3)
pcolor_alt_burst_anything(Data.Alt_Burst_AmpBeam3,Data), shading flat

subplot(4,1,4)
pcolor_alt_burst_anything(Data.Alt_Burst_AmpBeam4,Data), shading flat
datetick2('x')


function [] = pcolor_alt_burst_anything(matrix_to_plot,Data)

splitidx = find(diff(Data.Alt_Burst_Time)>.04);
idx_burst = ones(length(splitidx),2);
idx_burst(:,2) = splitidx;
idx_burst(2:end,1) = idx_burst(1:end-1,2)+1;


for i = 1:length(idx_burst)
    bi = idx_burst(i,1):idx_burst(i,2);
    pcolor(Data.Alt_Burst_Time(bi),[1:22],matrix_to_plot(bi,:)'), hold all
end



end


function [] = pcolor_vel_burst_by_burst(Data)

splitidx = find(diff(Data.Alt_Burst_Time)>.04);
idx_burst = ones(length(splitidx),2);
idx_burst(:,2) = splitidx;
idx_burst(2:end,1) = idx_burst(1:end-1,2)+1;


for i = 1:length(idx_burst)
    bi = idx_burst(i,1):idx_burst(i,2);
    subplot(411)
    pcolor(Data.Alt_Burst_Time(bi),[1:22],Data.Alt_Burst_VelBeam1(bi,:)'), shading flat, hold all
    subplot(412)
    pcolor(Data.Alt_Burst_Time(bi),[1:22],Data.Alt_Burst_VelBeam2(bi,:)'), shading flat, hold all
    subplot(413)
    pcolor(Data.Alt_Burst_Time(bi),[1:22],Data.Alt_Burst_VelBeam3(bi,:)'), shading flat, hold all
    subplot(414)
    pcolor(Data.Alt_Burst_Time(bi),[1:22],Data.Alt_Burst_VelBeam4(bi,:)'), shading flat, hold all
    
end

end




function [] = plot_bin1_4beam(Data)
ax(1) = subplot(4,1,1), plot(Data.Alt_Burst_Time,Data.Alt_Burst_VelBeam1(:,1))
title('beam 1')
hold all
ax(2) = subplot(4,1,2), plot(Data.Alt_Burst_Time,Data.Alt_Burst_VelBeam2(:,1)), title('beam 2')
hold all

ax(3) = subplot(4,1,3), plot(Data.Alt_Burst_Time,Data.Alt_Burst_VelBeam3(:,1)), title('beam 3')
hold all

ax(4) = subplot(4,1,4), plot(Data.Alt_Burst_Time,Data.Alt_Burst_VelBeam4(:,1)), title('beam 4')
hold all

linkaxes(ax,'y')

end

