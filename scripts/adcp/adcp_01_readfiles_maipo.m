% 16 january 2020
% M. Williams
% this file reads the two raw datafiles and outputs them to matlab format.
% uses rdradcp.m
% saves to edited_data folder
% 

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
save([saveloc,'adcp_day1_december_2019_maipo'],'adcp','cfg','datasource')
clearvars -except filenameday* saveloc

datasource = ['data from ',filenameday2];
[adcp,cfg]=rdradcp(filenameday2,1,[1 50079]); % last ensemble 50080, but sends a zero time, so eliminate
save([saveloc,'adcp_day2_december_2019_maipo'],'adcp','cfg','datasource')
