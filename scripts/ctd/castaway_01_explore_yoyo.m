clear
close all;

% this script requires GSW toolbox. Also probably datetick2.
addpath(genpath('~/Research/general_scripts/matlabfunctions/'))




load ../../raw_data/CastawayData/CC1547011_20191211_214422.mat
% runbelow(Time,Conductivity,Temperature,Pressure,CastTimeUtc)
% 
% load ../../raw_data/CastawayData/CC1547011_20191211_210857.mat % <-- script written on this one.
% runbelow(Time,Conductivity,Temperature,Pressure,CastTimeUtc)
% load ../../raw_data/CastawayData/CC1547011_20191211_204644.mat
% runbelow(Time,Conductivity,Temperature,Pressure,CastTimeUtc)
% load ../../raw_data/CastawayData/CC1547011_20191211_202016.mat
% runbelow(Time,Conductivity,Temperature,Pressure,CastTimeUtc)
% load ../../raw_data/CastawayData/CC1547011_20191211_193751.mat
% runbelow(Time,Conductivity,Temperature,Pressure,CastTimeUtc)
% load ../../raw_data/CastawayData/CC1547011_20191211_191342.mat
% runbelow(Time,Conductivity,Temperature,Pressure,CastTimeUtc)
% load ../../raw_data/CastawayData/CC1547011_20191211_173829.mat
% runbelow(Time,Conductivity,Temperature,Pressure,CastTimeUtc)
% load ../../raw_data/CastawayData/CC1547011_20191211_165950.mat
% runbelow(Time,Conductivity,Temperature,Pressure,CastTimeUtc)
% load ../../raw_data/CastawayData/CC1547011_20191211_162149.mat
% runbelow(Time,Conductivity,Temperature,Pressure,CastTimeUtc)
% load ../../raw_data/CastawayData/CC1547011_20191211_160826.mat
% runbelow(Time,Conductivity,Temperature,Pressure,CastTimeUtc)
% load ../../raw_data/CastawayData/CC1547011_20191211_153421.mat
% runbelow(Time,Conductivity,Temperature,Pressure,CastTimeUtc)
% 
% 
% load ../../raw_data/CastawayData/CC1547011_20191211_145832.mat
% runbelow(Time,Conductivity,Temperature,Pressure,CastTimeUtc)
% 
% % day 1
% load ../../raw_data/CastawayData/CC1547011_20191210_214842.mat
% runbelow(Time,Conductivity,Temperature,Pressure,CastTimeUtc)
% 
% load ../../raw_data/CastawayData/CC1547011_20191210_204152.mat
% runbelow(Time,Conductivity,Temperature,Pressure,CastTimeUtc)
% 
% load ../../raw_data/CastawayData/CC1547011_20191210_194148.mat
% runbelow(Time,Conductivity,Temperature,Pressure,CastTimeUtc)

load ../../raw_data/CastawayData/CC1547011_20191211_202624.mat
runbelow(Time,Conductivity,Temperature,Pressure,CastTimeUtc)




function [] = runbelow(Time,Conductivity,Temperature,Pressure,CastTimeUtc)

[rho,SA] = rho_cond_temp_pres(Conductivity/1000,Temperature,Pressure);
[casttimegmt] = get_cast_time_in_gmt(Time,CastTimeUtc)
figure, plottimetempcondpres(Time,Temperature,Conductivity,Pressure,CastTimeUtc)


[bottomval,bvidx]= findpeaks(Pressure,'minpeakheight',.5,'minpeakdistance',30);
[surfval,svidx]= findpeaks(-1*Pressure,'minpeakheight',-.4,'minpeakdistance',30);

% make these one set of indices.
pkidx = [bvidx;svidx]
pkval = [bottomval;-surfval];
% sort:
[pkidx_sorted,idxtosort] = sort(pkidx);
pkval = pkval(idxtosort);
pkidx = pkidx_sorted;
% threhold 0.4:
thresh = .4
yoyo = 1;
for i = 1:length(pkidx)-1
    startidx = pkidx(i);
    if pkval(i+1)>thresh
        endidx = pkidx(i+1)
        castidx{yoyo} = startidx:endidx;
        yoyo = yoyo+1;
    end
end


figure, plot(Pressure), hold all
for i = 1:length(castidx)
    plot(castidx{i},Pressure(castidx{i}),'r')
end
% return;
        
% get some details on cast:
castlength = 1;
for i = 1:length(castidx)
    timecastsec(i) = Time(castidx{i}(1));
    timecastgmt(i) = casttimegmt(castidx{i}(1));
    
    lengthcast(i) = length(castidx{i})
    if length(castidx{i})>castlength
        castlength = length(castidx{i})
    end

end

salt_matrix = NaN(length(castidx),25);
temp_matrix = salt_matrix;
dens_matrix = salt_matrix;
pres_unif = linspace(0,1.4,25);
    for i = 1:length(castidx)
        salt_matrix(i,:) = interp1(Pressure(castidx{i}),SA(castidx{i}),pres_unif);
                temp_matrix(i,:) = interp1(Pressure(castidx{i}),Temperature(castidx{i}),pres_unif);
                dens_matrix(i,:) = interp1(Pressure(castidx{i}),rho(castidx{i}),pres_unif);

    end
    
    figure
    subplot(3,1,1)
    pcolor(timecastsec,pres_unif,salt_matrix'), shading flat, axis ij
    cbax = colorbar;
    ylabel(cbax,'S_A (g/kg)')
    
 subplot(3,1,2)
    pcolor(timecastsec,pres_unif,temp_matrix'), shading flat, axis ij
        cbax = colorbar;
    ylabel(cbax,'T (C)')
 subplot(3,1,3)
    pcolor(timecastsec,pres_unif,dens_matrix'), shading flat, axis ij
    cbax = colorbar;
    ylabel(cbax,'\rho (kg/m^3)')
    
    
    
     figure(9)
    subplot(3,1,1)
    pcolor(timecastgmt,-pres_unif,salt_matrix'), shading flat, hold all
    cbax = colorbar;
    ylabel(cbax,'S_A (g/kg)')
    
 subplot(3,1,2)
    pcolor(timecastgmt,-pres_unif,temp_matrix'), shading flat, hold all
        cbax = colorbar;
    ylabel(cbax,'T (C)')
 subplot(3,1,3)
    pcolor(timecastgmt,-pres_unif,dens_matrix'), shading flat, hold all
    cbax = colorbar;
    ylabel(cbax,'\rho (kg/m^3)')
    datetick2('x')
    

% for i = 1:length(svidx)
    % logic to find if there is a bottom value index before the next
    % surface value index (since surface is a little more hand wavy)
%     find(svidx
    



% plottimetempcondpres(Time(1:end_down_idx),Temperature(1:end_down_idx),Conductivity(1:end_down_idx),Pressure(1:end_down_idx),CastTimeUtc)

figure
for i = 1:length(castidx)
    plot(SA(castidx{i}),Pressure(castidx{i})), hold all, xlabel('S_A (g/kg)'), ylabel('Pressure (dbar)'), grid on
end


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

    function [rho,SA] = rho_cond_temp_pres(conductivity,temperature,pressure)
        % copied from test_salinity_sebsitivity...
        
        long = -33;
        lat = -72;
        
        SP = gsw_SP_from_C(conductivity,temperature,pressure);
        SA = gsw_SA_from_SP(SP,pressure,long,lat);
        rho = gsw_rho(SA,gsw_CT_from_t(SA,temperature,pressure),pressure);
    end
    
    function [casttimegmt] = get_cast_time_in_gmt(Time,CastTimeUtc)
    casttimegmt = datenum(CastTimeUtc')+Time/(3600*24);
    end
    
end