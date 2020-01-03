% quick_plot_rbr_pressure_sensor.m 
% 03 January 2020
% m. williams
%
% plot the pressure data from the Maipo studies.
% 
% 042031_20191213_0312.rsk  
% 042031_20191218_1636.rsk 
% 
% this script uses RSKtools for reading the RSK files.
% the toolbox can be found at https://rbr-global.com/support/matlab-tools
% (though I may copy it to these scripts so they stand alone...)
% 
% saves ../../edited_data/rbr/two_pressure_records_raw.mat so I can save a
% few seconds looking at a quick wavelet analysis next. 
% 
% version: 3 jan 2020: just plots the data, saves the t and p from both sensors.
% 
% any updates please comment.

% the location of the rsk-tools on my computer. change to run on yours:
addpath(genpath('~/Research/general_scripts/matlabfunctions/rbr-rsktools/'))

%% Using the RBR RSK commands 

% RSK commands
rsk = RSKopen('../../raw_data/rbr/042031_20191213_0312.rsk');
rsk = RSKreaddata(rsk);
RSKplotdata(rsk);
title('Maipo Pressure 10-13 Dec. 2019') 
t1 = rsk.data.tstamp;
p1 = rsk.data.values;


% RSK commands
rsk = RSKopen('../../raw_data/rbr/042031_20191218_1636.rsk');
rsk = RSKreaddata(rsk);
figure
RSKplotdata(rsk);
title('Maipo Pressure 15-18 Dec. 2019') 
t2 = rsk.data.tstamp;
p2 = rsk.data.values;
%%
% 
% rsk = RSKopen('../../raw_data/rbr/042031_20191213_0312.rsk');
% rsk = RSKreaddata(rsk);
% 
% t1 = rsk.data.tstamp;
% p1 = rsk.data.values;

figure
plot(t1,p1), hold all
plot(t2,p2)
title('Pressure Sensor Maipo Inlet')
xlabel('Time, GMT')
ylabel('Raw pressure [dbar]')
grid on
set(gca,'tickdir','out')
datetick('x','dd mmm')
% clear rsk
% rsk = RSKopen('../../raw_data/rbr/042031_20191218_1636.rsk');
% rsk = RSKreaddata(rsk);

save ../../edited_data/rbr/two_pressure_records_raw t* p*
