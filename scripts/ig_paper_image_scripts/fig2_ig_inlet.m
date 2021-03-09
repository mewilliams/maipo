% 4 dec 2020
%
% m williams
% make figure 2(?) for GRL paper:
%
% should have: wavelet of pressure, pressure, velocity (ADCP), variance^2 =
% stdev(vel), and the same of the pressure?)

addpath ~/Research/general_scripts/matlabfunctions
jgr_figure_startup % sets axes out, small fonts.

clear
close all;

% run wavelet script (it also plots - but the plotting of wavelet and
% pressure just copied from over there once variables are made)
returnhere = pwd;
cd ../rbr/
run('quick_wavelet_maipo_pressure.m')
cd(returnhere)

xl = [datenum(2019,12,10,18,0,0) datenum(2019,12,12,18,0,0)];


%this file generated in adcp_07_ig_inlet_figure.m:
load ../../edited_data/adcp/adcp_day1_cell1_U_and_time

U_6minsmooth = smooth(U_fill10ma,6*60);
hold all



figure
ax(3) = subplot(6,1,4)
plot(timefill,U_fill10ma), hold all, grid on
plot(timefill,U_6minsmooth)
xlim(xl)

ax(4) = subplot(6,1,5)
plot(timefill,sqrt(movvar(U_fill10ma-U_6minsmooth,600))), hold all, grid on
xlim(xl)

% return;

load ../../edited_data/adcp/adcp_day2_cell1_U_and_time
U_6minsmooth = smooth(U_fill10ma,6*60);


ax(3) = subplot(6,1,4)
plot(timefill,U_fill10ma)
plot(timefill,U_6minsmooth)
ylabel('velocity [m/s]')
xlim(xl)

ax(4) = subplot(6,1,5)
plot(timefill,sqrt(movvar(U_fill10ma-U_6minsmooth,600))), hold all, grid on
ylabel('IG vel. [m/s]')
xlim(xl)


ax(1) = subplot(6,1,1:2)
pcolor(t1(idx),f1,abs(wt1)), shading flat
ylabel({'frequency','[hz]'})
xlim(xl)

% colorbar
disp(caxis)
caxis(ca)
set(gca,'yscale','log')
hold all
% plot(t1(idx),coi,'w','linewidth',2)
plot(xlim,ones(2,1)*(1/30),'w--','linewidth',2)
plot(xlim,ones(2,1)*(1/300),'w--','linewidth',2)

% fill a polygon over the COI:
fillT = t1(idx);
fillT(2:end+1) = fillT;
fillT(end+1) = fillT(end);

fillcoi = coi;
fillcoi(2:end+1) = fillcoi;
fillcoi(1) = min(coi); % not ze'ro because axis is log
fillcoi(end+1) = min(coi);
fill(fillT,fillcoi,'k')

datetick('x','keeplimits')

ax(2) = subplot(6,1,3);
plot(t1,p1), grid on
disp('using 16 hz pres.')
hold all
p1_6min = smooth(p1,6*60*16);
plot(t1,p1_6min)
ylabel({'pressure','[dbar]'})

% datetick('x')'

ax(5) = subplot(6,1,6);
% plot(t1,movvar(p1-p1_6min,6*60*16).^2)
plot(t1,movstd(p1-p1_6min,6*60*16)), hold all
grid on
ylabel('IG pres. [dbar]')
xlabel('10 - 12 December 2019')
% colorbar

% cd 


for i = 3:6
    subplot(6,1,i)
    xlim(xl)
    datetick('x','keeplimits')
end

savefig(gcf,'../../images/fig2_draft.fig')