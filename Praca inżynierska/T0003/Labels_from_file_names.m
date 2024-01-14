clear all; clc; close all;
%%

cd E:\Inżynierka\O0001\T0001 % Zamienić 'E:\Inżynierka\' jeżeli folder O0001 jest w innej lokalizacji

%% M plik tworzący kategoryczną macierz etykiet nagrań na podstawie nazwy pliku .wav

names = filenames2labels('T0002',FileExtensions=".wav"); 
names_str = string(names);
labels_log = endsWith(names_str,"o");
labels_log = ~labels_log;
labels = categorical(string(labels_log));

cd T0002\T0003

save('Labels_from_file_names.mat');

cd T0004