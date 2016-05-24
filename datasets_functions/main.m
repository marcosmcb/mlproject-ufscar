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

% Displays the menu options and gets back the user's answer
menu_resp = menu();

% Option to bypass this menu selection if a value not in 1-9 range is selected
if (menu_resp >= 1) && (menu_resp <= 10)
    displayColumnData( menu_resp, train_data );
end;


%% Functions' calls to normalize the datasets
fprintf('Normalizando os dados...\n\n\n');

% Gets the empty and noisy cells from the column AgesuponOutcome
[zeros_arr, empty_arr] = getEmptyAndZeroCells( train_data{8} );

% Removes empty cells, noisy ones ('0 years') and transform the data
train_data = cleanDataSet( train_data, empty_arr, zeros_arr);


ages_arr = normalizeAgeuponOutcome( train_data{8} );


% 'With name' == 1 and 'without name' == 0
names_arr = normalizeNames( train_data{2} );


% With dog == 1 and cat == 0
animal_type_arr = normalizeAnimalType( train_data{6} );


%SexUponOutCome cleaning
max = size(animal_type_arr);
sex_upon_out_come_arr = zeros(max);

%Breed cleaning
max = size(animal_type_arr);
breed_arr = zeros(max);

%Color cleaning
max = size(animal_type_arr);
color_arr = zeros(max);

%% Create a Final Clean and Top Matrix
MATRIX = [names_arr, animal_type_arr, sex_upon_out_come_arr, ages_arr, breed_arr, color_arr];


%% Call to logistic regression using the training data
%fprintf('pressione enter para chamar a regressao logistica');
%pause;
%logisticaDoida(train_data);

%% Exiting
%clear; close all;
