% 7 feb 2020
% m williams
% figure out how the castaway matlab data files work.
addpath(genpath('~/Research/general_scripts/matlabfunctions/'))
presentation_figure_startup


clear;
close all;

% filename is based on UTC time.
load ../../raw_data/CastawayData/CC1547011_20191211_210401.mat
make_various_plots(Time,Temperature,Conductivity,Pressure,CastTimeUtc)
load ../../raw_data/CastawayData/CC1547011_20191211_210455.mat
make_various_plots(Time,Temperature,Conductivity,Pressure,CastTimeUtc)

nine_pm_fns = dir('../../raw_data/CastawayData/CC1547011_20191211_21*');
for i = 1:length(nine_pm_fns)
    load(['../../raw_data/CastawayData/',nine_pm_fns(i).name])
    make_various_plots(Time,Temperature,Conductivity,Pressure,CastTimeUtc)
    pause
end

function [] = make_various_plots(Time,Temperature,Conductivity,Pressure,CastTimeUtc)

% if only one cast:
end_down_idx = find(Pressure==max(Pressure));
if length(end_down_idx)>1
    end_down_idx = end_down_idx(1);
end

figure, plottimetempcondpres(Time,Temperature,Conductivity,Pressure,CastTimeUtc)
plottimetempcondpres(Time(1:end_down_idx),Temperature(1:end_down_idx),Conductivity(1:end_down_idx),Pressure(1:end_down_idx),CastTimeUtc)

figure, plotprestempcond(Temperature,Conductivity,Pressure,CastTimeUtc)
plotprestempcond(Temperature(1:end_down_idx),Conductivity(1:end_down_idx),Pressure(1:end_down_idx),CastTimeUtc)


[rho,SA] = rho_cond_temp_pres(Conductivity/1000,Temperature,Pressure);

figure, plotpresrhosalinity(rho,SA,Pressure,CastTimeUtc)
% plot downcast:
plotpresrhosalinity(rho(1:end_down_idx),SA(1:end_down_idx),Pressure(1:end_down_idx),CastTimeUtc)



    function [] = plottimetempcondpres(Time,Temperature,Conductivity,Pressure,CastTimeUtc)
        subplot(3,1,1), plot(Time,Temperature), grid on, hold all
        ylabel('Temp. (C)')
        title([datestr(datenum(CastTimeUtc')),' UTC'])
        subplot(312), plot(Time,Conductivity), grid on, hold all
        ylabel('Cond (uS/cm)')
        subplot(313), plot(Time,Pressure), grid on, hold all
        ylabel('Pres. (dbar)')
        xlabel('cast time, seconds')
    end

    function [] = plotprestempcond(Temperature,Conductivity,Pressure,CastTimeUtc)
        ax2(1) = subplot(121), plot(Temperature,Pressure), grid on, hold all
        xlabel('Temp. (C)')
        ylabel('Pressure (dbar)')
        title([datestr(datenum(CastTimeUtc')),' UTC'])
        axis ij
        
        ax2(2) = subplot(122), plot(Conductivity,Pressure), grid on, hold all
        xlabel('Cond (uS/cm)')
        axis ij
        linkaxes(ax2,'y')
        % axis ij
    end


    function [] = plotpresrhosalinity(rho,SA,Pressure,CastTimeUtc)
        ax2(1) = subplot(121), plot(rho,Pressure), grid on, hold all
        xlabel('\rho (kg/m^3)')
        ylabel('Pressure (dbar)')
        title([datestr(datenum(CastTimeUtc')),' UTC'])
        axis ij
        
        ax2(2) = subplot(122), plot(SA,Pressure), grid on, hold all
        xlabel('Salinity (g/kg)')
        axis ij
        linkaxes(ax2,'y')
        % axis ij
    end


    function [rho,SA] = rho_cond_temp_pres(conductivity,temperature,pressure)
        % copied from test_salinity_sebsitivity...
        
        long = -33;
        lat = -72;
        
        SP = gsw_SP_from_C(conductivity,temperature,pressure);
        SA = gsw_SA_from_SP(SP,pressure,long,lat);
        rho = gsw_rho(SA,gsw_CT_from_t(SA,temperature,pressure),pressure);
    end

end