% adcp_06_moving_avg.m


mov_avg_samples = 10; 



%
k = ones(mov_avg_samples,1);
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

evconv(:,1:startidx) = NaN;
evconv(:,endidx:end) = NaN;
nvconv(:,1:startidx) = NaN;
nvconv(:,endidx:end) = NaN;
vvconv(:,1:startidx) = NaN;
vvconv(:,endidx:end) = NaN;

figure
subplot(311)
pcolor(adcp.mtime,cfg.ranges,evconv), shading flat, title('conv east'), colorbar

subplot(312)
pcolor(adcp.mtime,cfg.ranges,nvconv), shading flat,title('conv north'), colorbar

subplot(313)
pcolor(adcp.mtime,cfg.ranges,vvconv), shading flat, title('conv vert'), colorbar


%% 
% sanity check the moving average is ok:
figure
subplot(211)
plot(adcp.mtime,eastvel(1,:)), hold all
plot(adcp.mtime,conv(eastvel(1,:),k,'same'))
plot(adcp.mtime,evconv(1,:))
subplot(212) 
plot(adcp.mtime, conv(eastvel(1,:),k,'same') - evconv(1,:))

% plot(adcp.mtime,evconv(1,:))
