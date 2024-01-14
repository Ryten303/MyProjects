clear all; clc; close all;
%%
cd ..

load('Sorted_features.mat')

cd T0010
%% Sieć
inputSize = length(features(1,:));
% numHiddenUnits = ceil(height(features)./(10*size(features,2)*height(cnt_Train)));
numHiddenUnits = 50;
numClasses = height(cnt_Train);
miniBatchSize = 32;
Val_freq = 50;
maxEpochs = 20000;
initialLearnRate = 4e-6;
learnRateDropPeriod = 200;
learnRateDropFactor = 0.5;
l2Regulatization = 9e-4;
maxFail = 100;

%  layers = [ ...
%     sequenceInputLayer(inputSize)
%     bilstmLayer(numHiddenUnits,OutputMode="last")
%     fullyConnectedLayer(numClasses)
%     softmaxLayer
%     classificationLayer]

layers = [ ...
    sequenceInputLayer(inputSize)
    bilstmLayer(numHiddenUnits,OutputMode="last")
    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer]


delete(gcp('nocreate'))
% parpool('Threads')
parpool('Processes')
options = trainingOptions("adam", ...
    GradientThreshold=1, ...
    MaxEpochs = maxEpochs, ...
    MiniBatchSize=miniBatchSize, ...
    SequenceLength="longest", ...
    Shuffle="never", ...
    Verbose=0, ...
    InitialLearnRate = initialLearnRate, ...
    ValidationData = {Cell_of_features_Test', labels_val}, ... Do walidacji
    ValidationFrequency = Val_freq, ...    
    ExecutionEnvironment='parallel', ...
    Plots="training-progress");
%     L2Regularization= l2Regulatization, ...
%     LearnRateSchedule="piecewise", ...
%     LearnRateDropPeriod= learnRateDropPeriod, ...
%     LearnRateDropFactor= learnRateDropFactor, ...
%     ValidationPatience = maxFail, ... 

for i=1:length(Cell_of_labels)
    Cell_of_features{i}=Cell_of_features{i}'
end

net = trainNetwork(Cell_of_features,labels_Train,layers,options);

%%
save('Trained_model.mat');

cd T0011