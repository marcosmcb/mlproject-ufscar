%% Universidade Federal de Sao Carlos - UFSCar, Sorocaba
%  Projeto Final de Aprendizado de Máquina
%  Function: normalizeAndCleanerColors
%  Help:
%  Colunas de Resultado:
%  1 -          Names               (1 - se tem nome, 0 - c.c.);
%  2 -          Animal Type         (1 - Dog, 0 - Cat);
%  3 - 7 -      Sex Upon Out Come   (Vetor de Bits com 5 possibilidades);
%  8 -          Ages                (Valor em dias da idade);
%  9 - 390 -    Breed(main)         (Vetor de Bits com 382 possiblidades);
%  391 - 536 -  Breed(secondary)    (Vetor de Bits com 146 possiblidades);
%  537 - 560 -  Color(properly)     (Vetor de Bits com 24 possiblidades);
%  561 - 573 -  Color(pattern)      (Vetor de Bits com 12 possiblidades);
%  574 - 577 -  Class(RESULT)       (Vetor de Bits com 5 possibilidades);

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
	%[train_data10a, train_data10b ] = strtok(train_data(10), '/');
    [colors, patterns] = splitColorAndPattern( train_data(10) );
% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


% ====================== Results cleaning ======================
	results = dummyvar( grp2idx( train_data{4} ) );
% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++




%% Create a Final Clean and Top Matrix
MATRIX = [names_arr, animal_type_arr, sex_upon_out_come_arr, ages_arr, breed_arr1, breed_arr2, colors, patterns, results];

MATRIX(isnan(MATRIX)) = 0;
fprintf('Imprindo os dados em um arquivo: "datasetNormalAndCleanColors.csv "...\n\n');
dlmwrite('../datasets_normal&clean/datasetNormalAndCleanColors.csv',MATRIX);

%% Exiting
clear; close all;