clear;
close all;

load ../../edited_data/adcp/in_water_indices_rdi_adcp.mat
load ../../edited_data/adcp/adcp_day2_december_2019_maipo.mat
load ../../edited_data/adcp/lastbinindex_day2.mat

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


figure
subplot(311)
imagesc(adcp.mtime,cfg.ranges,eastvel), shading flat, title('edited + 1')

subplot(312)
imagesc(adcp.mtime,cfg.ranges,northvel), shading flat, title('edited + 1')

subplot(313)
imagesc(adcp.mtime,cfg.ranges,vertvel), shading flat, title('edited + 1')


%%
k = ones(5,1);
k = k./sum(k);
sum(k)
evconv = NaN(size(eastvel));
nvconv = NaN(size(eastvel));
vvconv = NaN(size(eastvel));
for j = 1:19
evconv(j,:) = conv(eastvel(j,:),k,'same');
nvconv(j,:) = conv(northvel(j,:),k,'same');
vvconv(j,:) = conv(vertvel(j,:),k,'same');
end

figure
subplot(311)
pcolor(adcp.mtime,cfg.ranges,evconv), shading flat, title('conv east'), colorbar

subplot(312)
pcolor(adcp.mtime,cfg.ranges,nvconv), shading flat,title('conv north'), colorbar

subplot(313)
pcolor(adcp.mtime,cfg.ranges,vvconv), shading flat, title('conv vert'), colorbar
%% 

figure
plot(adcp.mtime,eastvel(1,:)), hold all
plot(adcp.mtime,conv(eastvel(1,:),k,'same'))
plot(adcp.mtime,evconv(1,:))
% plot(adcp.mtime,evconv(1,:))
