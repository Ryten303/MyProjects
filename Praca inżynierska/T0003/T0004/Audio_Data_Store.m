clear all; clc; close all;
%%
cd ..

% load ('Labels_from_file_names.mat')
load ('Labels_from_file_names_4.mat')

cd T0004
%% Zapis plików .wav do obiektu Audio Data Store

ADS = audioDatastore('E:\Inżynierka\O0001\T0001\T0002\'); % ADS to obiekt potrzebny do zarządzania plikami audio
ADS.Labels = labels; % wgranie macierzy etykiet do ADS

[ADS_Train, ADS_Test] = splitEachLabel(ADS,0.8);

cnt_Train= countlabels(ADS_Train.Labels); % Policzenie poszczególnych etykiet
cnt_Test= countlabels(ADS_Test.Labels);

[sampleADS_Train,dsInfo] = read(ADS_Train); % odczyt ADS do struktury dsInfo

reset(ADS_Train); 

save('Audio_Data_Store.mat');

cd T0005