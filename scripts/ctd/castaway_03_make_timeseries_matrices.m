% castaway_03_make_timeseries_matrices.m
%
% m williams
% 8 feb 2020


clear;
close all


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

mid_cloud = 219; % a representative location for the LTV casts...
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
    saltmatrix(i,:) = interp1(prescast{closeidx(i)},salinitycast{closeidx(i)},presvec);
    rhomatrix(i,:) = interp1(prescast{closeidx(i)},rho{closeidx(i)},presvec);
    tempmatrix(i,:) = interp1(prescast{closeidx(i)},tempcast{closeidx(i)},presvec);
    
end


