clear all; clc; close all;
%%
cd ..

load("Features.mat");

cd T0006
%% Dane do Classification learner

features_table = array2table(features);
class_learner_labels = [];
for i=1:height(Cell_of_labels)
    class_learner_labels_buff = Cell_of_labels{i}(:,1);
    class_learner_labels = [class_learner_labels;class_learner_labels_buff];
end
class_learner_labels_buff = [];

features_table_Test = array2table(features_test);
class_learner_labels_Test = [];
for i=1:height(Cell_of_labels_Test)
    class_learner_labels_buff = Cell_of_labels_Test{i}(:,1);
    class_learner_labels_Test = [class_learner_labels_Test; class_learner_labels_buff];
end

save ('Classification_Learner_workspace.mat')

classificationLearner

% Należy wybrać:
%   New session from workspace
%   Data set variable: features_table
%   Response: from workspace i class_learner_labels
%   Reszta dowolnie
