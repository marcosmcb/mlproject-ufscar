%% Universidade Federal de Sao Carlos - UFSCar, Sorocaba
%
%  Disciplina: Aprendizado de Maquina
%  Prof. Tiago A. Almeida
%
%  Projeto Aprendizado de Máquina - Shelter Animal Outcomes ( www.kaggle.com )
%
%% Initialization
clear all; close all; clc;

%% Load the train dataset as well as the test dataset 
fprintf('Carregando os dados...\n\n');
[ train_data, test_data ] = readData();

% Displays the menu options and gets back the user's answer
menu_resp = menu();
<<<<<<< HEAD
displayColumnData( menu_resp, train_data );
=======

% Option to bypass this menu selection if a value not in 1-9 range is selected
if (menu_resp >= 1) && (menu_resp <= 10)
    displayColumnData( menu_resp, train_data );
end;
>>>>>>> 217a62990648f68560cce0a71e8801f534b150ee

%% Functions' calls to normalize the datasets
fprintf('Normalizando os dados...\n\n\n');

% Gets the empty and noisy cells from the column AgesuponOutcome
[zeros_arr, empty_arr] = getEmptyAndZeroCells( train_data{8} );

% Removes empty cells, noisy ones ('0 years') and transform the data
train_data = cleanDataSet( train_data, empty_arr, zeros_arr );

ages_arr = normalizeAgeuponOutcome( train_data{8} );

% Gives back the ages (in days) multiplyed by its respective value in days
% parameters:   array of cell strings
% return:       double array
ages_arr = normalizeAgeuponOutcome( train_data{8} );

% With name == 1 and without name == 0
% parameters:   array of cell strings
% return:       logical array
names_arr = normalizeNames( train_data{2} );


% With dog == 1 and cat == 0
% parameters:   array of cell strings
% return:       logical array
animal_type_arr = normalizeAnimalType( train_data{6} );


%% Call to logistic regression using the training data
fprintf('pressione enter para chamar a regressao logistica\n');
pause;
logisticaDoida(train_data);

%% Exiting
clear; close all;
