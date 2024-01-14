clear all; clc; close all;
%%
cd ..

load('Trained_model.mat')

cd T0011

%% Testowanie sieci 
numObservations_Test = numel(Cell_of_features_Test);
for i=1:numObservations_Test
    sequence_Test = Cell_of_features_Test{i};
    sequenceLengths_Test(i) = size(sequence_Test,1);
end
clear idx;
[sequenceLengths_Test,idx] = sort(sequenceLengths_Test);
Cell_of_features_Test = Cell_of_features_Test(idx);
Cell_of_labels_Test = Cell_of_labels_Test(idx);

%%
for i=1:length(Cell_of_labels_Test)
    Cell_of_features_Test{i}=Cell_of_features_Test{i}; % Jak pojawi się error to dodać albo usunąć ' przy Cell_of_features_Test{i}
end

Label_Pred = classify(net,Cell_of_features_Test', ...
    MiniBatchSize=miniBatchSize, ...
    SequenceLength="longest");

labels_Test=ADS_Test.Labels;
Label_Pred == labels_Test
acc = sum(Label_Pred == labels_Test)./numel(labels_Test);
disp(['Test accuracy is ' num2str(acc)])
%% Zapis workspace
acc_str = mat2str(acc);
acc_str = replace(acc_str,".",",");

L2R_str = mat2str(l2Regulatization);
L2R_str = replace(L2R_str,".",",")

name_workspace = ["net_h",mat2str(numHiddenUnits),...
    "_b",mat2str(miniBatchSize), ...
    "_e",mat2str(maxEpochs), ...
    '_acc',mat2str(acc_str),...
    '_il',mat2str(initialLearnRate), ...
    'L2R', mat2str(L2R_str)]
name_workspace = join(name_workspace,'_')

%%

cd T0012
save(name_workspace);
