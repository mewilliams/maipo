clear all;

close all;

load ../../edited_data/dispersion_U_S_X_T.mat

Urdi = U;

load ../../edited_data/rbr/two_pressure_records_raw.mat
load ../../edited_data/rbr/indices_in_water.mat
p1 = p1(inwater1);
t1 = t1(inwater1);

p2 = p2(inwater2);
t2 = t2(inwater2);

figure(99)
plim = [10 11.5];
subplot(3,2,1)
plot(t1,smooth(p1,16*5*60),'k'), hold all
xl1 = xlim;
yl = plim;
ylim(plim)
TL = [T(1) T(end)];
patch([TL(1) TL(1) TL(2) TL(2)],[yl(1) yl(2) yl(2) yl(1)],'b','edgecolor','none','facealpha',0.1)

ylabel('P (dbar)')
xlim(xl1);
datetick('x','dd mmm','keeplimits')
ylim([10 11.5])
subplot(323)

plot(T,U,'k'), ylabel('U (m/s)'), ylim([-1.25 1.25])
xlim(xl1);
datetick('x','dd mmm','keeplimits')
subplot(325)
plot(T,S,'k.'), ylabel('S')
ylim([0 35])
xlim(xl1);
datetick('x','dd mmm','keeplimits')
% datetick2('x')
% 
% for i =1:3
% subplot(3,1,i)
% grid on
% grid minor
% end



load ../../edited_data/dispersion_analysis/maipo_UXS_aqd_fsi_2.mat 



figure(12)
subplot(211)
plot(XiS/1000,S,'kx'), grid on, ylabel('S')
ylim([0 35])
xlabel('X (km)')

subplot(212)
plot(X/1000,Sbin,'ko'), grid on, ylabel('S')
xlabel('X (km)')
xl2x = xlim;

ylim([0 35])
subplot(211), 
xlim(xl2x)

return;


% figure(100)
figure(99)

subplot(3,2,2)
plot(t2,smooth(p2,16*5*60),'k'), hold all
yl = ylim;
xl2 = xlim;
datetick('x','dd mmm','keeplimits')
ylim(plim)
yl = plim;
TL = [tbin(1) tbin(end)];
patch([TL(1) TL(1) TL(2) TL(2)],[yl(1) yl(2) yl(2) yl(1)],'b','edgecolor','none','facealpha',0.1)

ylabel('Pressure (dbar)')
subplot(324)
plot(tbin,-U,'k'), ylabel('U (m/s)'), ylim([-1.25 1.25])
hold all
xlim(xl2)
datetick('x','dd mmm','keeplimits')
subplot(326)

plot(tbin,Sbin,'k'), ylabel('S')% (g/kg)')
hold all
ylim([0 35])
xlim(xl2)
datetick('x','dd mmm','keeplimits')

load ../../edited_data/dispersion_analysis/maipo_UXS_aqd_fsi_1.mat 
subplot(324)
plot(tbin,-U,'k')
subplot(326)
plot(tbin,Sbin,'k')

subplot(322)
yl = ylim;
TL = [tbin(1) tbin(end)];
patch([TL(1) TL(1) TL(2) TL(2)],[yl(1) yl(2) yl(2) yl(1)],'b','edgecolor','none','facealpha',0.1)


for i = 1:6
subplot(3,2,i)
grid on
grid minor
end
% 
% 
% datetick2('x')
% 
% for i =1:3
% subplot(3,1,i)
% grid on
% grid minor
% end


 ixp2 = [486856
     1258631
     1908123
     2723105
     3381361
     4146746];
 yl = [10 11.5];
 for i = 1:length(ixp2)
%      yl = ylim;
plot(t2(ixp2(i))*ones(2,1),yl,'k--')

disp(datestr(t2(ixp2(i))))
 end
     