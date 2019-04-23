clear all;
close all;
clc;
data = csvread('training_data.csv');
[M,N]=size(data);
indices_first_set=1:round((M*0.8));
indices_second_set=setdiff(1:M,indices_first_set);
training_data_first_set=data(indices_first_set,:);
training_data_second_set=data(indices_second_set,:);
csvwrite('training_data_first_set.csv',training_data_first_set);
csvwrite('training_data_second_set.csv',training_data_second_set);

