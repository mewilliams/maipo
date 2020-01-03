%%  Maipo ADCP processing
%%  Dec 12, 2019

clear all

day = 'day2';
direct = ['/Volumes/LaCie/MAIPO/ADCP/ADCP' day '/'];
filename = [direct 'MAIPO001.000'];

[ADCP,CFG]=rdradcp(filename);

savefilename = [direct 'ADCP_proc.mat']
save(savefilename, 'ADCP', 'CFG')

loacalsavefilename = ['MAT/' day '/' 'ADCP_proc.mat']
save(loacalsavefilename, 'ADCP', 'CFG')


