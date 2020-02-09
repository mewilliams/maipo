%%  Bin average by time
%   Modified from RISE analysis files
%   /Users/arhd/Dropbox/Alex/mfiles/RISE/Analysis/Ri_E

%%  function
function [Xbin, tbin, NinBin]=time_binavg_fun(X,dt,t,bin_start,bin_end)

if isnan(bin_start)
    bins=min(t):dt:max(t); %disp('min start')
else
    bins=bin_start:dt:bin_end;
end
Nbins=length(bins);
tbin=(bins(1:end-1)+bins(2:end))/2; %centers

for ii=1:Nbins-1
    cast_inds=find(t>bins(ii)&t<bins(ii+1));
    NinBin(ii)=length(cast_inds);
    if isvector(X)
        Xbin(ii)=nanmean(X(cast_inds),2);
    else
        Xbin(:,ii)=nanmean(X(:,cast_inds),2);
    end
end
    
    