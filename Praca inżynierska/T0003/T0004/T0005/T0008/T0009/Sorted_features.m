clear all; clc; close all;
%%
cd ..

load('Features_cell.mat')

cd T0009
%% W macierzy sequenceLengths znajdują się liczby sekwencji cech dla każdego nagrania
numObservations = numel(Cell_of_features);
for i=1:numObservations
    sequence = Cell_of_features{i};
    sequenceLengths(i) = size(sequence,1);
end
figure;
subplot(3,1,1)
bar(sequenceLengths);
xlabel("$Nagrania$",'interpreter', 'latex')
ylabel("$l [-]$",'interpreter', 'latex')
box off
grid on
%% Sortowanie wg. długości sekwencji
[sequenceLengths,idx] = sort(sequenceLengths);
Cell_of_features = Cell_of_features(idx);
Cell_of_labels = Cell_of_labels(idx);

labels_Train=ADS_Train.Labels;
labels_Train(idx_e) = [];
labels_Train = labels_Train(idx);
labels_Train=labels_Train';

subplot(3,1,2)
bar(sequenceLengths);
xlabel("$Nagrania$",'interpreter', 'latex')
ylabel("$l [-]$",'interpreter', 'latex')
box off
grid on

for i = 1:length(Cell_of_features)
    if sequenceLengths(i) < mean(sequenceLengths) - mean(sequenceLengths)/2
        delete_border = sequenceLengths(i);
        delete_idx = i;
    end
end

Cell_of_features(1:delete_idx) = [];
Cell_of_labels (1:delete_idx) = [];
sequenceLengths(1:delete_idx) = [];
labels_Train(1:delete_idx) = [];

subplot(3,1,3)
bar(sequenceLengths);
xlabel("$Nagrania$",'interpreter', 'latex')
ylabel("$l [-]$",'interpreter', 'latex')
box off
grid on
%% Walidacja w trakcie uczenia
for i=1:height(Cell_of_labels_Test)
    labels_val(i) = Cell_of_labels_Test{i}(1,1);
end
labels_val = labels_val';

for i=1:length(Cell_of_labels_Test)
    Cell_of_features_Test{i}=Cell_of_features_Test{i}';
end
%%

save('Sorted_features.mat');

cd T0010