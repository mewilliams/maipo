clear all;
close all;


load ../../edited_data/adcp/in_water_indices_rdi_adcp.mat

% 
% load ../../edited_data/adcp/adcp_day2_december_2019_maipo.mat
% startidx = startidx_day2;
% endidx = endidx_day2;

load ../../edited_data/adcp/adcp_day1_december_2019_maipo.mat
startidx = startidx_day1;
endidx = endidx_day1;



subplot(511), pcolor(adcp.mtime(startidx:endidx),cfg.ranges,squeeze(adcp.intens(:,1,startidx:endidx))), shading flat, cbax = colorbar;
ylabel(cbax,'EA 1')
subplot(512), pcolor(adcp.mtime(startidx:endidx),cfg.ranges,squeeze(adcp.intens(:,2,startidx:endidx))), shading flat, cbax = colorbar;
ylabel(cbax,'EA 2')
subplot(513), pcolor(adcp.mtime(startidx:endidx),cfg.ranges,squeeze(adcp.intens(:,3,startidx:endidx))), shading flat, cbax = colorbar;
ylabel(cbax,'EA 3')
subplot(514), pcolor(adcp.mtime(startidx:endidx),cfg.ranges,squeeze(adcp.intens(:,4,startidx:endidx))), shading flat, cbax = colorbar;
ylabel(cbax,'EA 4')

subplot(515), pcolor(adcp.mtime(startidx:endidx),cfg.ranges,squeeze(nanmean(adcp.intens(:,:,startidx:endidx),2))), shading flat, cbax = colorbar;
ylabel(cbax,'Avg. EA')
%%
avg_EA = squeeze(nanmean(adcp.intens,2));

max_EA_bin = NaN(5,length(adcp.mtime));

for idx = startidx:endidx
    max_avgEAidx = find(avg_EA(:,idx) == max(avg_EA(:,idx)));
    if length(max_avgEAidx)>1
        max_avgEAidx = max_avgEAidx(end);
    end
    
    max_EA_bin(5,idx) = max_avgEAidx;
    lastbin(idx) = cfg.ranges(max_avgEAidx);
    
   maxEAbin1idx = find(adcp.intens(:,1,idx) == max(adcp.intens(:,1,idx)));
   if length(maxEAbin1idx)>1
        maxEAbin1idx = maxEAbin1idx(end);
    end
    
    max_EA_bin(1,idx) = maxEAbin1idx;
    lastbin1(idx) = cfg.ranges(maxEAbin1idx);

    
    
   maxEAbin2idx = find(adcp.intens(:,2,idx) == max(adcp.intens(:,2,idx)));
   if length(maxEAbin2idx)>1
        maxEAbin2idx = maxEAbin2idx(end);
    end
    
    max_EA_bin(2,idx) = maxEAbin2idx;
    lastbin2(idx) = cfg.ranges(maxEAbin2idx);

        
   maxEAbin3idx = find(adcp.intens(:,3,idx) == max(adcp.intens(:,3,idx)));
   if length(maxEAbin3idx)>1
        maxEAbin3idx = maxEAbin3idx(end);
    end
    
    max_EA_bin(3,idx) = maxEAbin3idx;
    lastbin3(idx) = cfg.ranges(maxEAbin3idx);
    
      
   maxEAbin4idx = find(adcp.intens(:,4,idx) == max(adcp.intens(:,4,idx)));
   if length(maxEAbin4idx)>1
        maxEAbin4idx = maxEAbin4idx(end);
    end
    
    max_EA_bin(4,idx) = maxEAbin4idx;
    lastbin4(idx) = cfg.ranges(maxEAbin4idx);
    
    
  
end


figure
imagesc(adcp.mtime(startidx:endidx),cfg.ranges,squeeze(nanmean(adcp.intens(:,:,startidx:endidx),2))), shading flat
hold on
plot(adcp.mtime(startidx:endidx),lastbin(startidx:endidx))
axis xy

% lastbin = NaN(length(adcp.mtime),1);
% for idx = startidx_day2:endidx_day2
    