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

addpath('./datasets_functions');
addpath('./RedesNeurais');

%% Load the train dataset as well as the test dataset 
fprintf('Carregando os dados...\n\n');
[ train_data, test_data ] = readData();

% Displays the menu options and gets back the user's answer
menu_resp = menu();

% Option to bypass this menu selection if a value not in 1-9 range is selected
if (menu_resp >= 1) && (menu_resp <= 10)
    displayColumnData( menu_resp, train_data );
end;


%% Functions' calls to normalize the datasets
fprintf('Normalizando os dados...\n\n\n');
[ train_dataset_normalized, train_dataset_colour, train_dataset_breed, train_dataset_no_colour_breed ] = normalizeDataset( train_data );


%% Call to Logistic Regression using the training data
fprintf('pressione enter para chamar a regressao logistica\n');
pause;
RL_init(train_dataset_normalized, test_data);

%% Exiting
clear; close all;
