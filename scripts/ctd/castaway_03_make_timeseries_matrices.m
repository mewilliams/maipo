% castaway_03_make_timeseries_matrices.m
%
% m williams
% 8 feb 2020

%
clear;
% close all

load ../../edited_data/ctd/castaway/castaway_downcasts_20191211_maipo.mat

%uncomment to save other file:
load ../../edited_data/ctd/castaway/castaway_downcasts_20191210_maipo.mat

tv = datevec(timecast(1));



if and(tv(2)==12,tv(3)==10)
    savefn = '../../edited_data/ctd/castaway/castaway_matrices_20191210_maipo.mat'

elseif and(tv(2)==12,tv(3)==11)
        savefn = '../../edited_data/ctd/castaway/castaway_matrices_20191211_maipo.mat'

else
    disp('not saving or running, check which files input')
    return;
end

    

% run after castaway_02_extract_downcasts

% now make a matrix to interpolate on, for plotting, etc.

% first get the deepest point:
maxpres = 0.2;
for i =1:length(prescast)
    if max(prescast{i})>maxpres
        maxpres = max(prescast{i})
    end
end
disp(['deepest point is ','num2str(maxpres)',' dbar'])

[X,Y,zone]=ll2utm(latitudestartcast,longitudestartcast);
% return;


if and(tv(2)==12,tv(3)==10)
    mid_cloud = 109; % on DAY 1
elseif and(tv(2) ==12,tv(3)==11)
    mid_cloud = 219; % on DAY 2 % a representative location for the LTV casts...
    
else
    disp('you need to find a reference point, these')
    disp('data are not 10 or 11 dec 2019')
    return;
end

ltv_loc = [X(mid_cloud)    Y(mid_cloud)]; % UTM approx - picked a point.

dist_from_ltv = sqrt((X-ltv_loc(1)).^2 + (Y - ltv_loc(2)).^2);
closeidx = find(dist_from_ltv<20); % 20 meters from the location.
maxpresltv = 0.1;
for i = closeidx
    if max(prescast{i})>maxpresltv
        maxpresltv = max(prescast{i});
    end
end


% make a matrix of density, salinity, temperature:
nbins = 25;
saltmatrix = NaN(length(closeidx),nbins);
tempmatrix = saltmatrix;
rhomatrix = saltmatrix;

presvec = linspace(0,maxpresltv,nbins);
timevec = timecast(closeidx);


for i = 1:length(closeidx)
    % known problem closeidx(126) on day 1:
    if i==126
        if and(tv(2)==12,tv(3)==10)
            p = prescast{closeidx(i)};
            s = salinitycast{closeidx(i)};
            r = rho{closeidx(i)};
            tem = tempcast{closeidx(i)};
            
            ixs = find(p>.05,1,'first');
            ixe = length(p);
            
            saltmatrix(i,:) = interp1(p(ixs:ixe),s(ixs:ixe),presvec);
            rhomatrix(i,:) = interp1(p(ixs:ixe),r(ixs:ixe),presvec);
            tempmatrix(i,:) = interp1(p(ixs:ixe),tem(ixs:ixe),presvec);
            
            
        end
    else
        
        saltmatrix(i,:) = interp1(prescast{closeidx(i)},salinitycast{closeidx(i)},presvec);
        rhomatrix(i,:) = interp1(prescast{closeidx(i)},rho{closeidx(i)},presvec);
        tempmatrix(i,:) = interp1(prescast{closeidx(i)},tempcast{closeidx(i)},presvec);
    end
end

%%

figure
subplot(311), pcolor(timevec,-presvec,saltmatrix'),shading flat
title(datestr(timecast(1),'dd mmm yyyy'))
cbax = colorbar;
ylabel(cbax,'S_A (g/kg)')
subplot(312), pcolor(timevec,-presvec,tempmatrix'),shading flat
cbax = colorbar;
ylabel(cbax,'T (C)')
subplot(313), pcolor(timevec,-presvec,rhomatrix'),shading flat
cbax = colorbar;
ylabel(cbax,'\rho (kg/m^3)')
datetick2('x')


save(savefn,'saltmatrix','rhomatrix','tempmatrix','timevec','presvec')

