%%  Plot Maipo CT data

clear all
load MAT/Maipo_YSI_CT

for ii=1:2:5
        
    figure(ii)
    %   Salinity
    ax1=subplot(311);
    plot(ysi(ii+1).yday, ysi(ii+1).sal,'k', ysi(ii).yday, ysi(ii).sal,'b');
    %plot( ysi(ii).yday, ysi(ii).sal,'b');
    legend('bottom','top')
    ylabel('S')
    if ii==1
        title('Channel')
    elseif ii==3
        title('SZ South')
    else
        title('SZ North')
    end

    %   Temperature
    ax2=subplot(312);
    plot(ysi(ii+1).yday, ysi(ii+1).temp,'k', ysi(ii).yday, ysi(ii).temp,'b');
    legend('bottom','top')
    ylabel('T')

    %   Pressure
    ax3=subplot(313);
    plot(ysi(ii+1).yday, ysi(ii+1).press,'k', ysi(ii).yday, ysi(ii).press,'b');
    legend('bottom','top')
    ylabel('P')
    xlabel('year day')
    
    linkaxes([ax1 ax2 ax3],'x')

end

figure(10)
ax4=subplot(311);
plot(ysi(2).yday, ysi(2).sal,'k', ysi(1).yday, ysi(1).sal,'b');
legend('bottom','top')
ylabel('S')
title('Channel salinity')

ax5=subplot(312);
plot(ysi(4).yday, ysi(4).sal,'k', ysi(3).yday, ysi(3).sal,'b');
legend('bottom','top')
ylabel('S')
title('SZS salinity')

ax6=subplot(313);
plot(ysi(6).yday, ysi(6).sal,'k', ysi(5).yday, ysi(5).sal,'b');
legend('bottom','top')
ylabel('S')
title('SZN salinity')

linkaxes([ax4 ax5 ax6],'x')