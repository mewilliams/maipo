% 11 feb 2020
% m williams
addpath(genpath('~/Research/general_scripts/matlabfunctions/'))
poster_figure_startup

clear all;
close all;

load ../../edited_data/dispersion_analysis/maipo_UXS_aqd_fsi_2.mat

figure, plot(X,Sbin,'ko')

