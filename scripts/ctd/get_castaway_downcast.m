function [castidx] = get_castaway_downcast(Pressure)
% [castidx] = get_castaway_downcast(Pressure)
% gets indices of downcast
% should work for both single cast and yoyo
%
% M. Williams
% 08 February 2020

disp('function designed for Maipo inlet')
disp('where measurements were made in approx.')
disp('1.5 m of water. Adjustments may be needed')
disp('for deeper water.')

thresh = .4;

Pmax = max(Pressure);
if Pmax>.6
mindepth = 0.6;
minsurface = 0.3;
elseif Pmax>.15
    mindepth = 0.3;
    minsurface = 0.2;
    thresh = 0.25;
else
%     castidx = NaN;
    return;
end

[bottomval,bvidx]= findpeaks(Pressure,'minpeakheight',mindepth,'minpeakdistance',30);
[surfval,svidx]= findpeaks(-1*Pressure,'minpeakheight',-minsurface,'minpeakdistance',30);


% make these one set of indices.
pkidx = [bvidx;svidx];
pkval = [bottomval;-surfval];
% sort:
[pkidx_sorted,idxtosort] = sort(pkidx);
pkval = pkval(idxtosort);
pkidx = pkidx_sorted;
% threhold 0.4:
yoyo = 1;
for i = 1:length(pkidx)-1
    startidx = pkidx(i);
    if pkval(i+1)>thresh
        endidx = pkidx(i+1);
        castidx{yoyo} = startidx:endidx;
        yoyo = yoyo+1;
    end
end