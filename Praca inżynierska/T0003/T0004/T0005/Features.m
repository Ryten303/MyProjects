clear all; clc; close all;
%%
cd ..

load ('Audio_Data_Store.mat')

cd T0005
%% Wydobycie cech sygnałów - końcowy efekt to macierz features i features_test

fs = dsInfo.SampleRate;  %częstotliwość próbkowania 96000 Hz
windowLength = round(0.03*fs);
overlapLength = round(0.025*fs); %% ustawienie jakimi przedziałami będzie dzwięk analizowany w celu wydobucia cech

afe = audioFeatureExtractor(SampleRate=fs, ...
    Window = hamming(windowLength,"periodic"), ...
    OverlapLength = overlapLength, ...
    shortTimeEnergy=true, ...
    pitch=false, ...
    mfcc=true, ...
    barkSpectrum=false ...
    );

featureMap = info(afe) %Szkielet wekotra cech <- ostatecznie 14, ponieważ energy jest kasowane później

features = [];

energyThreshold = 0.003; % taki sam próg minimalnej enrgii jak w przykładzie z mowy

keepLen = round(length(sampleADS_Train)/3); % W pętli analizowana jest 1/3 sygnału audio
i=0;
Cell_of_labels=cell(size(ADS_Train.Labels(:,1))); %komórka ostatecznych etykiet po rozbicu na cechy


while hasdata(ADS_Train) %Warunek istnienia danych w bazie danych audio
    i=i+1;
    [audioIn,dsInfo] = read(ADS_Train); 

    % Take the first portion of each recording to speed up code
    audioIn = audioIn(1:keepLen); 

    feat = extract(afe,audioIn); % wydobycie cech
    isSound = feat(:,featureMap.shortTimeEnergy) > energyThreshold; %Sprawdzenie czy energia jest nad progiem

    feat(~isSound,:) = []; % Wyrzucenie ciszy z sygnału
    feat(:,featureMap.shortTimeEnergy) = []; % Wyrzucenie energii z wektora uczącego
    

    label = repelem(dsInfo.Label,size(feat,1),size(feat,1)); % etykiety względem cech

    Cell_of_labels(i)={label}; % Zapis etykiet względem cech do komórki
    
    features = [features;feat]; % Zbiorcza macierz cech
    numFeatures = size(features,1);

end

emptyCells = cellfun(@isempty,Cell_of_labels); %% Wyrzucenie pustych komórek
idx_e = emptyCells;
Cell_of_labels(emptyCells)=[];

%% Wydobycie cech do wektora testującego

features_test = [];
[sampleADS_Test,dsInfo_test] = read(ADS_Test); % odczyt ADS do struktury dsInfo
reset(ADS_Test); 
keepLen = round(length(sampleADS_Test)/3); % W pętli analizowana jest 1/3 sygnału audio

Cell_of_labels_Test = cell(size(ADS_Test.Labels(:,1)));

while hasdata(ADS_Test) %Warunek istnienia danych w bazie danych audio
    i=i+1;
    [audioIn,dsInfo_test] = read(ADS_Test); 

    % Take the first portion of each recording to speed up code
    audioIn = audioIn(1:keepLen); 

    feat_test = extract(afe,audioIn); % wydobycie cech
    isSound = feat_test(:,featureMap.shortTimeEnergy) > energyThreshold; %Sprawdzenie czy energia jest nad progiem


    feat_test(~isSound,:) = []; % Wyrzucenie ciszy z sygnału
    feat_test(:,featureMap.shortTimeEnergy) = []; % Wyrzucenie energii z wektora uczącego
    
    label_test = repelem(dsInfo_test.Label,size(feat_test,1),size(feat_test,1)); % etykiety względem cech

    Cell_of_labels_Test(i)={label_test}; % Zapis etykiet względem cech do komórki
    
    features_test = [features_test;feat_test]; % Zbiorcza macierz cech
    numFeatures_test = size(features_test,1);

end
emptyCells = cellfun(@isempty,Cell_of_labels_Test); %% Wyrzucenie pustych komórek
Cell_of_labels_Test(emptyCells)=[];
%%
data = readall(ADS)
figure; mfcc(cell2mat(data(1)), fs);
xlabel('$t[s]$','Interpreter','latex');
ylabel('$MFCC$','Interpreter','latex');
figure; mfcc(cell2mat(data(306)), fs);
xlabel('$t[s]$','Interpreter','latex');
ylabel('$MFCC$','Interpreter','latex');
%%
fs = 96000;
timeVector = linspace(0,length(sampleADS_Train)/fs,numel(sampleADS_Train)); 
figure;
subplot(2,1,1)
plot(timeVector,sampleADS_Train);
sampleADS_Train(1:3000)=NaN;
sampleADS_Train(326000:end)=NaN;
timeVector(1:3000)=NaN;
timeVector(326000:end)=NaN;
xlabel('$t [s]$','Interpreter','latex')
ylabel('$A [-]$','Interpreter','latex')
box off
grid on
subplot(2,1,2)
plot(timeVector,sampleADS_Train);
xlabel('$t [s]$','Interpreter','latex')
ylabel('$A [-]$','Interpreter','latex')
xlim([0 6])
box off
grid on
%%
b = hz2mel([20,20000]);

melVect = linspace(b(1),b(2),10000);

hzVect = mel2hz(melVect);
figure;
semilogx(hzVect,melVect)
% title('Mel vs Hz')
xlabel('$f [Hz]$','Interpreter','latex')
ylabel('$f_{mel} [Hz]$','Interpreter','latex')
box off
grid on
%%
save('Features.mat');

cd T0008