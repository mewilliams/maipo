% 16 january 2020
% M. Williams

clear;
close all

% for location of rdradcp.m script
addpath ~/Research/general_scripts/matlabfunctions/RDADCP/


filenameday1 = '../../raw_data/adcp/ADCPday1/MAIPO000.000';
filenameday2 = '../../raw_data/adcp/ADCPday2/MAIPO001.000';

saveloc = '../../edited_data/adcp/'

%  [..]=rdradcp(NAME,NUMAV,[NFIRST NEND])
[adcp,cfg]=rdradcp(filenameday1,1,[1 57557]); % last ensemble 57558, but sends a zero time, so eliminate
datasource = ['data from ',filenameday1];
save([saveloc,'adcp_day1_december_2019_maipo'],adcp,cfg,datasource)
clearvars -except filenameday* saveloc

datasource = ['data from ',filenameday2];
[adcp,cfg]=rdradcp(filenameday2,1,-1);
save([saveloc,'adcp_day2_december_2019_maipo'],adcp,cfg,filenameday2)
