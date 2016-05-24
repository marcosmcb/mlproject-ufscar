%% Universidade Federal de Sao Carlos - UFSCar, Sorocaba
%
%  Disciplina: Aprendizado de Maquina
%  Prof. Tiago A. Almeida
%
%  Projeto Aprendizado de Máquina - Shelter Animal Outcomes ( www.kaggle.com )
%
%  Instrucoes
%  ----------
%
%

%% Initialization
clear all; close all; clc;

%% Load the train dataset as well as the test dataset 
fprintf('Carregando os dados...\n\n');
[ train_data, test_data ] = readData();

%% Functions' calls to normalize the datasets
fprintf('Normalizando os dados...\n\n\n');

% Gets the empty and noisy cells from the column AgesuponOutcome
[zeros_arr, empty_arr] = getEmptyAndZeroCells( train_data{8} );

% Removes empty cells, noisy ones ('0 years') and transform the data
train_data = cleanDataSet( train_data, empty_arr, zeros_arr);


% =================== AgeUponOutCome cleaning ==================
	ages_arr = normalizeAgeuponOutcome( train_data{8} );
% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



% ====================== Names cleaning ========================
% 'With name' == 1 and 'without name' == 0
	names_arr = normalizeNames( train_data{2} );
% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



% =================== AnimalType cleaning ======================
	% With 'dog' == 1 and 'cat' == 0
	animal_type_arr = normalizeAnimalType( train_data{6} );
% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



% ================= SexUponOutCome cleaning ====================
	sex_upon_out_come_arr = dummyvar( train_data(7) );
% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



% ======================= Breed cleaning =======================
	[train_data9a, train_data9b ] = strtok(train_data(9), '/');
	breed_arr1 = dummyvar( train_data9a );
	breed_arr2 = dummyvar( train_data9b );
% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



% ====================== Color cleaning ========================
	[train_data10a, train_data10b ] = strtok(train_data(10), '/');
	color_arr1 = dummyvar( train_data10a );
	color_arr2 = dummyvar( train_data10b );
% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

%% Create a Final Clean and Top Matrix
MATRIX = [names_arr, animal_type_arr, sex_upon_out_come_arr, ages_arr, breed_arr1, breed_arr2, color_arr1, color_arr2];

MATRIX(isnan(MATRIX)) = 0;

dlmwrite('../datasets_normal&clean/datasetNormalAndClean.csv',MATRIX);

%% Exiting
clear; close all;