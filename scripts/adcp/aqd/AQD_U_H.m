%%  Load and plot AQD files



%%  Load file

clear all
%ppath = '/Data/Maipo/AQD/Converted/';
ppath = '/Users/arhd/Dropbox/Alex/Data/Maipo/AQD/Converted/';

filenum=2
if filenum==1
    fname = 'DC01_M01';
    startnum = 12100; %11500;
    endnum =  42000; %43000;
elseif filenum==2
    fname = 'DC01_N01';
    startnum = 9505;
    endnum = 50718;  %Last data are bad
elseif filenum==3
    fname = 'DC01_M02';
    startnum = 1;
    endnum = 71570;
elseif filenum==4
    fname = 'DC01_M02';
    startnum = 83210;
    endnum = 175525;
elseif filenum==5
    fname = '3_mai';
    startnum = 1;
    endnum = 78982;
elseif filenum==6
    fname = '4_mai';
    startnum = 1;
    endnum = 104887;
end

load([ppath fname]);
disp(['Loading ' ppath fname]);

%%  Load salinity
load('MAT/Maipo_YSI_CT')
disp('Loading MAT/Maipo_YSI_CT');

%%  Set times

starttime = datenum(Vtime(1,startnum), Vtime(2,startnum), Vtime(3,startnum), Vtime(4,startnum), Vtime(5,startnum), Vtime(6,startnum));
endtime = datenum(Vtime(1,endnum), Vtime(2,endnum), Vtime(3,endnum), Vtime(4,endnum), Vtime(5,endnum), Vtime(6,endnum));
datarange = startnum:endnum;

Sstartnum = closest(ysi(1).time(:),starttime); Sstattime = ysi(1).time(Sstartnum);
Sendnum = closest(ysi(1).time(:),endtime); Sendtime = ysi(1).time(Sendnum);
Sdatarange = Sstartnum:Sendnum;

%%  Variable
tt= datenum(Vtime(1,datarange), Vtime(2,datarange), Vtime(3,datarange), Vtime(4,datarange), Vtime(5,datarange), Vtime(6,datarange));


if filenum == 3 | filenum == 4
    t1 = datenum(Vtime(1,1), Vtime(2,1), Vtime(3,1), Vtime(4,1), Vtime(5,1), Vtime(6,1));
    tt = t1 + (0:(length(Vtime)-1))*1/24/3600;
    disp('Fabricated time')
    starttime = tt(startnum);
    endtime = tt(endnum);
    tt=tt(datarange);
end

instrDepth = 0.1;
if filenum < 5
    y = instrDepth + blanking + (0:24)*cellsize;
else
    y = instrDepth + blanking + (0:19)*cellsize;
end

%%  velocity magnitude
umag = sqrt(Vvel1.^2 + Vvel2.^2);
u=umag;
floodheading=240;
floodflag = find(Vheading > floodheading);
u(:,floodflag)=-u(:,floodflag);

%%  ABS adjust

[m,n] = size(Vamp1);
coeff = 0.2;
aten = exp(coeff*y);
ATEN = repmat(aten',1,n);
echo1(:,:) = Vamp1.*ATEN;
echo2(:,:) = Vamp2.*ATEN;
echo3(:,:) = Vamp3.*ATEN;
pcolor(tt, -y, (echo1(:,datarange))), shading flat, colorbar, %caxis([70 86])

%%  10min bins
deltaminutes = 10;
dt = datenum(2019,12,13,0,deltaminutes,0) - datenum(2019,12,13,0,0,0);

[ubin, tbin, NinBin]=time_binavg_fun(u(:,datarange),dt,tt,starttime,endtime);
[Echobin, tbin, NinBin]=time_binavg_fun(echo1(:,datarange),dt,tt,starttime,endtime);
[Sbin, tbin, NinBin]=time_binavg_fun(ysi(1).sal',dt,ysi(1).time,starttime,endtime);
[Tbin, tbin, NinBin]=time_binavg_fun(ysi(1).temp',dt,ysi(1).time,starttime,endtime);

rhobin = gsw_rho(Sbin,Tbin,0);
rhoocean = gsw_rho(34,14,0);

%%  Extract H
maxdepth = 3.5;
maxdepthind = closest(y, maxdepth);
[Y, botind] = max(Echobin,[],1);
H_raw = y(botind);
H = medfilt1(H_raw,10);

%%  Depth average U
U = mean(ubin(1:botind,:),1);



%%  Lnf

gp = 9.8*(rhoocean-rhobin)./rhoocean;
%gp=9.8*(rhoocean - 1000)./rhoocean;
gp=0.1;
W = 30/2; %assume triangular
Q = U.*H.*W;Qc=Q;
Qr=1;
we = 0.015;

M = Qc.*U;
J = Qr.*gp;

Lnf = U.^(1.5).*Q.^(0.25)./(gp.^(0.5).*we);

%Lnf = M^(3/4)


%%  Plotting
figure(1)
subplot(411)
pcolor(tbin, -y, ubin), shading flat, colorbar, caxis([-1 1])
datetick('x')
axis([starttime endtime -4 0])
%title('Vel mag')
hold on
plot(tbin,-H,'k')
ylabel('z and H, m')
pos1 = get(gca,'position');


subplot(412)
plot(tbin,U)
datetick('x')
axis([starttime endtime -1.5 1.5])
hold on, plot(tbin, zeros(size(tbin)),'k')
pos2 = get(gca,'position');
set(gca,'position',[pos2(1:2) pos1(3) pos2(4)])
ylabel('U, m/s')


subplot(413)
plot(ysi(1).time(Sdatarange), ysi(1).sal(Sdatarange))
hold on
plot(tbin, Sbin,'r'), hold off
datetick('x')
axis([starttime endtime 15 35])
pos3 = get(gca,'position');
set(gca,'position',[pos3(1:2) pos1(3) pos3(4)])
ylabel('S')

figure(2)
subplot(411)
plot(tbin,U)
datetick('x')
axis([starttime endtime -1.5 1.5])
hold on, plot(tbin, zeros(size(tbin)),'k')
ylabel('U, m/s')

subplot(412)
plot(tbin,Q)
datetick('x')
axis([starttime endtime -40 40])
ylabel('Q, m^3/s')

subplot(413)
plot(tbin,gp)
datetick('x')
axis([starttime endtime 0 0.2])
ylabel('gp, m/s^2')

subplot(414)
plot(tbin,Lnf)
datetick('x')
xlim([starttime endtime])
ylabel('L_{nf}')
    
    
    
    
    
    
    