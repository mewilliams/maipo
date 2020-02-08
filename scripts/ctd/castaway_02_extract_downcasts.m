% 8 february 2020
% m williams
%

% this script requires GSW toolbox. Also probably datetick2. And requires
% ll2utm.m to convert lat/long to UTM
addpath(genpath('~/Research/general_scripts/matlabfunctions/'))

clear
close all;

dec11savename = '../../edited_data/ctd/castaway/castaway_downcasts_20191211_maipo.mat'
dec10savename = '../../edited_data/ctd/castaway/castaway_downcasts_20191210_maipo.mat'


dirpath = ['../../raw_data/CastawayData/'];

dec11fn = dir([dirpath,'CC1547011_20191211*']);
dec10fn = dir([dirpath,'CC1547011_20191210*']);

% fn = dec11fn;
fn = dec10fn;

% want to put these in structures, I guess..
ci = 1;
tempcast{ci} = NaN;
condcast{ci} = NaN;
prescast{ci} = NaN;

timecast(ci) = NaN;
latitudestartcast(ci) = NaN;
longitudestartcast(ci) = NaN;

for i = 1:length(fn)
    
    load([dirpath,fn(i).name])
    if max(Pressure)>0.15
        %     if IsInvalid==1
        %         if max(Pressure)<0.1
        %             disp(num2str(i))
        %             return;
        %         end
        %     end
        [castidx] = get_castaway_downcast(Pressure);
        %         if isfinite(castidx)
        
        %%%%%
        % UNCOMMENT TO PLOT ALL THE PRESSURE RECORDS TO SEE DOWNCAST
        % INDICES ARE OK:
        %         figure, plot(Pressure), hold all
        %         for j = 1:length(castidx)
        %             plot(castidx{j},Pressure(castidx{j}),'r')
        %         end
        %%%%%
        
        for j = 1:length(castidx)
            
            %structures because changing lengths
            tempcast{ci} = Temperature(castidx{j});
            condcast{ci} = Conductivity(castidx{j});
            prescast{ci} = Pressure(castidx{j});
            
            % these should be vectors
            timecast(ci) = datenum(CastTimeUtc')+Time(castidx{j}(1))/(3600*24);
            latitudestartcast(ci) = LatitudeStart;
            longitudestartcast(ci) = LongitudeStart;
            
            ci = ci+1;
            
        end
        
    end
end


for i =1:length(condcast)
    [rho{i},salinitycast{i}] = rho_cond_temp_pres(condcast{i}./1000,tempcast{i},prescast{i});
    
end


if and(CastTimeUtc(2)==12,CastTimeUtc(3)==11)
    savename = dec11savename;
elseif and(CastTimeUtc(2)==12,CastTimeUtc(3)==10)
    savename = dec10savename;
else
    disp('not saving anything')
    return;
end

save(savename,'rho','salinitycast','*startcast','tempcast','condcast','prescast','timecast')


function [rho,SA] = rho_cond_temp_pres(conductivity,temperature,pressure)
% copied from test_salinity_sebsitivity...

long = -33;
lat = -72;

SP = gsw_SP_from_C(conductivity,temperature,pressure);
SA = gsw_SA_from_SP(SP,pressure,long,lat);
rho = gsw_rho(SA,gsw_CT_from_t(SA,temperature,pressure),pressure);
end

