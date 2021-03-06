% 10 april 2020
% m williams
% 
%
% spectral analysis of temperature and pressure records first.

% clear
% close all;


idxleg = 1;

load ../../raw_data/signature/S100882A011_Maipo_Dec_2.mat

figure(502)
subplot(2,1,1), 
plot(Data.Alt_Burst_Time,Data.Alt_Burst_Pressure,'.'), hold all
ylabel('P')

subplot(2,1,2), 
plot(Data.Alt_Burst_Time,Data.Alt_Burst_Temperature,'.'), hold all
ylabel('T')
% 
%  [legentry,idxleg] = run_twice(Data,idxleg)
% load ../../raw_data/signature/S100882A011_Maipo_Dec_2.mat
%  [legentry,idxleg] = run_twice(Data,idxleg)
% 
% 
% function [legentry,idxleg] = run_twice(Data,idxleg)

% by inspection Fs = 4Hz;
fs = 4;
% find burst splits: 
splitidx = find(diff(Data.Alt_Burst_Time)>.04);
idx_burst = ones(length(splitidx),2);
idx_burst(:,2) = splitidx;
idx_burst(2:end,1) = idx_burst(1:end-1,2)+1;


for i = 1:length(idx_burst)
    bi = idx_burst(i,1):idx_burst(i,2);
    t = Data.Alt_Burst_Time(bi);
    disp(datestr(mean(t)))
    P = Data.Alt_Burst_Pressure(bi);
    T = Data.Alt_Burst_Temperature(bi);
    
    figure(20)
if i ==1
    subplot(4,1,1), plot(t,P), hold all
    subplot(413), plot(t,T), hold all
    
    Tdt = detrend(T);
    Pdt = detrend(P); 
    subplot(412), plot(t,Pdt), hold all
        subplot(414), plot(t,Tdt), hold all
else
       subplot(4,1,1), plot(t,P,'k'), hold all
    subplot(413), plot(t,T,'k'), hold all
    
    Tdt = detrend(T);
    Pdt = detrend(P); 
    subplot(412), plot(t,Pdt,'k'), hold all
        subplot(414), plot(t,Tdt,'k'), hold all
end
    
        % don't use this except right now to test...:
        
% d_detrend_all = detrend(d);
pxxT = periodogram(Tdt);
pxxP = periodogram(Pdt);

hT = dspdata.psd(pxxT,'Fs',fs);
figure(8);
% loglog(1./hT.frequencies,hT.data.*hT.frequencies), hold all
loglog(hT.frequencies,hT.data), hold all

xlabel('Freq [Hz]')
ylabel('Energy')
title('Temp....')

hP = dspdata.psd(pxxP,'Fs',fs);
figure(9);
% loglog(1./hP.frequencies,hP.data.*hP.frequencies), hold all
loglog(hP.frequencies,hP.data), hold all

xlabel('Freq [Hz]')
ylabel('Energy')
title('Pressure....')

% or with fft instead of dspdata.psd:
period = 1/fs;
L = length(t)
f = fs*(0:(L/2))/L;
t_sec = (0:L-1)*period;
plot(t_sec,Pdt);

Y = fft(Pdt.*hanning(length(Pdt)));
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

Yt = fft(Tdt.*hanning(length(Tdt)));
P2t = abs(Yt/L);
P1t = P2t(1:L/2+1);
P1t(2:end-1) = 2*P1t(2:end-1);

figure(99)
subplot(3,1,[2 3])
plot(f,P1), hold all
set(gca,'xscale','log')
subplot(311)
plot(t,P), hold all
datetick('x')

figure(100)
subplot(3,1,[2 3])
plot(f,P1t), hold all
set(gca,'xscale','log')
subplot(311)
plot(t,T), hold all
datetick('x')



legentry{idxleg} = datestr(mean(t));
idxleg = idxleg+1;

    
end
% end
