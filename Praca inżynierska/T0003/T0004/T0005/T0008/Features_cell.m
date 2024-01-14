clear all; clc; close all;
%% 
% Bez selekcji cech:
cd ..

load('Features.mat')

cd T0008

%% Z selekcją cech. Jeżeli używana jest selekcja odkomentować tą sekcję i zakomentować poprzednią
% cd ..
% cd T0007
% 
% load('Feature_Selection.mat')
% 
% cd ..
% cd T0008
%% Pętle do stworzenia komórki cech Cell_of_features i Cell_of_features_test
leng_feat_old=1;
Cell_of_features=cell(size(ADS_Train.Labels(:,1)));
Cell_of_features(idx_e) = [];
i=1;
for i=1:length(Cell_of_features)
    leng_feat=size(Cell_of_labels{i},1);
    
    if(i==1)
        buff_feature=features(leng_feat_old:leng_feat,:);
    else
        buff_feature=features(leng_feat_old:leng_feat+leng_feat_old-1,:);
    end
    Cell_of_features{i}=buff_feature;
    leng_feat_old=leng_feat_old+leng_feat-1;
    
end
emptyCells = cellfun(@isempty,Cell_of_features); %% Wyrzucenie pustych komórek
Cell_of_features(emptyCells)=[];

leng_feat_old=1;
Cell_of_features_Test=cell(size(ADS_Test.Labels(:,1)));
i=1;
for i=1:length(Cell_of_features_Test)

    leng_feat=size(Cell_of_labels_Test{i},1);
    
    if(i==1)
        buff_feature_test=features_test(leng_feat_old:leng_feat,:);
    else
        buff_feature_test=features_test(leng_feat_old:leng_feat+leng_feat_old-1,:);
    end

    Cell_of_features_Test{i}=buff_feature_test;
    leng_feat_old=leng_feat_old+leng_feat-1;
    
end
emptyCells = cellfun(@isempty,Cell_of_features_Test); %% Wyrzucenie pustych komórek
Cell_of_features_Test(emptyCells)=[];

%% Przykładowe pokazanie cech dla pierwszego nagrania
figure
plot(Cell_of_features{1})
xlabel("Time Step")
title("Training Observation 1")
numFeatures = size(Cell_of_features{1},2);
legend("Feature " + string(1:numFeatures),Location="northeastoutside")

figure
plot(Cell_of_features_Test{1})
xlabel("Time Step")
title("Testing Observation 1")
numFeatures_Test = size(Cell_of_features_Test{1},2);
legend("Feature " + string(1:numFeatures_Test),Location="northeastoutside")
%%

save('Features_cell.mat');

cd T0009