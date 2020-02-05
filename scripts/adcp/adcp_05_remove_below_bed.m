clear;
close all;

load ../../edited_data/adcp/in_water_indices_rdi_adcp.mat

% day 2
load ../../edited_data/adcp/adcp_day2_december_2019_maipo.mat
load ../../edited_data/adcp/lastbinindex_day2.mat
savename = ['../../edited_data/adcp/adcp_day2_december_2019_maipo_usable.mat'];
startidx = startidx_day2;
endidx = endidx_day2;
runtwice(adcp,cfg,lastbinidx,startidx,endidx,savename)


% day 1
load ../../edited_data/adcp/adcp_day1_december_2019_maipo.mat
load ../../edited_data/adcp/lastbinindex_day1.mat
savename = ['../../edited_data/adcp/adcp_day1_december_2019_maipo_usable.mat'];
startidx = startidx_day1;
endidx = endidx_day1;
runtwice(adcp,cfg,lastbinidx,startidx,endidx,savename)


function [] = runtwice(adcp,cfg,lastbinidx,startidx,endidx,savename)
eastvel = adcp.east_vel;
subplot(3,1,1)
imagesc(adcp.mtime,cfg.ranges,eastvel), shading flat, title('raw')
for i = 1:length(lastbinidx)
    if isfinite(lastbinidx(i))
        
        eastvel(lastbinidx(i):19,i) = NaN;
    end
end
subplot(312)
imagesc(adcp.mtime,cfg.ranges,eastvel), shading flat, title('edited')

eastvel = adcp.east_vel;
northvel = adcp.north_vel;
vertvel = adcp.vert_vel;

subplot(313)
for i = 1:length(lastbinidx)
    if isfinite(lastbinidx(i))
       
        eastvel(lastbinidx(i)+1:19,i) = NaN;
        northvel(lastbinidx(i)+1:19,i) = NaN;
        vertvel(lastbinidx(i)+1:19,i) = NaN;
    end
end
imagesc(adcp.mtime,cfg.ranges,eastvel), shading flat, title('edited + 1')


eastvel(:,1:startidx) = NaN;
eastvel(:,endidx:end) = NaN;
northvel(:,1:startidx) = NaN;
northvel(:,endidx:end) = NaN;
vertvel(:,1:startidx) = NaN;
vertvel(:,endidx:end) = NaN;

save(savename,'eastvel','northvel','vertvel')


figure
subplot(311)
imagesc(adcp.mtime,cfg.ranges,eastvel), shading flat, title('edited + 1')

subplot(312)
imagesc(adcp.mtime,cfg.ranges,northvel), shading flat, title('edited + 1')

subplot(313)
imagesc(adcp.mtime,cfg.ranges,vertvel), shading flat, title('edited + 1')

end