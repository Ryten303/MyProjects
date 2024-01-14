clear all; clc; close all;
%% 

cd ..
cd T0006

load("Classification_Learner_workspace.mat");

cd ..
cd T0007

% WAŻNE: Wybrać jedną z dwóch selekcji: MRMR albo minmax i zakomentować
% drugą sekcję. 

%% Opcjonalne przypisanie wag cechom za pomoocą algorytmu MRMR

feature_names = features_table.Properties.VariableNames
features_table_Test.Properties.VariableNames = feature_names;

[idx, MRMR_score] = fscmrmr([features_table ; features_table_Test], [class_learner_labels ; class_learner_labels_Test])

figure;
bar(MRMR_score(idx))
xlabel('Predictor rank')
ylabel('Predictor importance score')
xticklabels(strrep(feature_names(idx),'_','\_'))

for i = 1:size(features,2)
    features(:,i) = features(:,i)*MRMR_score(:,i);
    features_test(:,i) = features_test(:,i)*MRMR_score(:,i);
end


%% Minmax cech 
% minimum = min(min(features));
% maximum = max(max(features));
% minimum_t = min(min(features_test));
% maximum_t = max(max(features_test));
% minimum = min([minimum_t,minimum]);
% maximum = max([maximum_t,maximum]);
% H = maximum-minimum;
% 
% for i=1:height(features)
%     for j=1:size(features,2)
%         features(i,j)=(features(i,j)-minimum)/H;
%     end
% end
% 
% for i=1:height(features_test)
%     for j=1:size(features_test,2)
%         features_test(i,j)=(features_test(i,j)-minimum)/H;
%     end
% end

%%

save('Feature_selection.mat');

cd ..
cd T0008