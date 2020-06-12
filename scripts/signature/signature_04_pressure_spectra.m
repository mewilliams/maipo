% m williams
% 11 June 2020
%
%
% try to get some spectra from the pressure sensor in the Maipo Signature
% data... version 1.0 11 june 2020

clear all;
close all;


% SPLIT 2
load ../../raw_data/signature/S100882A011_Maipo_Dec_2.mat

% indices for bursts of average time
% by inspection: average_time has a 1Hz sampling rate,
% samples for 2 minutes every 10 min, except during
% the wave burst (Alt_Burst_Time) when it does not record
% an average pressure.
biav(:,2) = find(diff(Data.Average_Time)>.004); % .004 by inspection
biav(1,1) = 1;
biav(2:end,1) = biav(1:end-1,2)+1;

% check burst indexing is correct:
figure(1)
plot(Data.Average_Time,Data.Average_Pressure,'ko'), hold all
for i = 1:length(biav)
    plot(Data.Average_Time(biav(i,1):biav(i,2)),Data.Average_Pressure(biav(i,1):biav(i,2)))
    hold all
end
datetick2('x')


for i = 1:15 %second file has 15 average bursts
    ti = Data.Average_Time(biav(i,1):biav(i,2));
    pi = Data.Average_Pressure(biav(i,1):biav(i,2));
    pidt = detrend(pi);
    figure(2)
    subplot(211), plot(ti,pi), hold all
    subplot(212), plot(ti,pidt), hold all
    
    fs = 1;
    nfft = length(pidt);
    %     nfft = 2^nextpow2(length(pidt));
    
    
    PdB_Hz= 10*log10(pxx);                  % dBW/Hz
    
    figure(3)
    plot(f,PdB_Hz), hold all
%     figure
    
    T = 1./f;
    figure(97)
    plot(T(2:end),PdB_Hz(2:end)), hold all
    
end

%%

bib(:,2) = find(diff(Data.Burst_Time)>.03); % .004 by inspection
bib(1,1) = 1;
bib(2:end,1) = bib(1:end-1,2)+1;


for i = 1:3%length(bib) %second file has 3 "bursts"
    tib = Data.Burst_Time(bib(i,1):bib(i,2));
    pib = Data.Burst_Pressure(bib(i,1):bib(i,2));
    pibdt = detrend(pib);
    figure(4)
    subplot(211), plot(tib,pib), hold all
    subplot(212), plot(tib,pibdt), hold all
    
    fs = 8;
    nfft = 2^12;
    wind= rectwin(nfft);
    [pxx,f]= pwelch(pibdt,wind,0,nfft,fs);
    figure(6)
    plot(f,pxx), hold all
end

%%

clear all
close all
load ../../raw_data/signature/S100882A011_Maipo_Dec_1.mat
load ../../edited_data/rbr/two_pressure_records_raw


clear biab
biab(:,2) = find(diff(Data.Alt_Burst_Time)>.03); % .004 by inspection
biab(1,1) = 1;
biab(2:end,1) = biab(1:end-1,2)+1;
C = linspecer(6);
spno = 1;
spno6 = spno;

for i = 1:length(biab) %second file has 3 "bursts"
    tiab = Data.Alt_Burst_Time(biab(i,1):biab(i,2));
    piab = Data.Alt_Burst_Pressure(biab(i,1):biab(i,2));
    piabdt = detrend(piab);
    
    idx_rbr = find(and(t2>=tiab(1),t2<=tiab(end)));
    ti_rbr = t2(idx_rbr);
    pi_rbr = p2(idx_rbr);
    pirbrdt = detrend(pi_rbr);
    
    figure(40)
    subplot(211), plot(tiab,piab), hold all
    subplot(212), plot(tiab,piabdt), hold all
    plot(ti_rbr,pirbrdt)
    
    fs = 4;
    nfft = 2^11;
    wind= rectwin(nfft);
    [pxx,f]= pwelch(piabdt,wind,0,nfft,fs);
    figure(7)
    plot(f,pxx), hold all
    
    % rbr
    fsrbr = 16;
     nfft = 2^13;
    wind= rectwin(nfft);
    [pxxrbr,frbr]= pwelch(pirbrdt,wind,0,nfft,fsrbr);
    figure(17)
    plot(frbr,pxxrbr), hold all
    
    figure(19)
    ax(spno) = subplot(3,2,spno), plot(f,pxx,'color',C(spno,:)), hold on
    figure(20)
    plot(tiab,piab,'color',C(spno,:)), hold on
    
    
    figure(25)
    subplot(6,2,spno6), plot(f,pxx,'color',C(spno,:)), hold on, spno6 = spno6+1;
    subplot(6,2,spno6), plot(frbr,pxxrbr,'color',C(spno,:)), hold on, spno6 = spno6+1;


    spno = spno+1;

    
end
% return

clearvars -except spno* C t2 p2 
load ../../raw_data/signature/S100882A011_Maipo_Dec_2.mat

biab(:,2) = find(diff(Data.Alt_Burst_Time)>.03); % .004 by inspection
biab(1,1) = 1;
biab(2:end,1) = biab(1:end-1,2)+1;

for i = 1:2%length(biab) %second file has 3 "bursts"
    tiab = Data.Alt_Burst_Time(biab(i,1):biab(i,2));
    piab = Data.Alt_Burst_Pressure(biab(i,1):biab(i,2));
    piabdt = detrend(piab);
    
    idx_rbr = find(and(t2>=tiab(1),t2<=tiab(end)));
    ti_rbr = t2(idx_rbr);
    pi_rbr = p2(idx_rbr);
    pirbrdt = detrend(pi_rbr);
    
    figure(40)
    subplot(211), plot(tiab,piab), hold all
    subplot(212), plot(tiab,piabdt), hold all
    plot(ti_rbr,pirbrdt)
    
    fs = 4;
    nfft = 2^11;
    wind= rectwin(nfft);
    [pxx,f]= pwelch(piabdt,wind,0,nfft,fs);
    figure(7)
    plot(f,pxx), hold all
    
     % rbr
    fsrbr = 16;
     nfft = 2^13;
    wind= rectwin(nfft);
    [pxxrbr,frbr]= pwelch(pirbrdt,wind,0,nfft,fsrbr);
    figure(17)
    plot(frbr,pxxrbr), hold all
    
      figure(19)
    ax(spno) = subplot(3,2,spno), plot(f,pxx,'color',C(spno,:)), hold on
    figure(20)
    plot(tiab,piab,'color',C(spno,:)), hold on
    spno = spno+1;
    
      
    figure(25)
    subplot(6,2,spno6), plot(f,pxx,'color',C(spno,:)), hold on, spno6 = spno6+1;
    subplot(6,2,spno6), plot(frbr,pxxrbr,'color',C(spno,:)), hold on, spno6 = spno6+1;


    
end