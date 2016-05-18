%% Universidade Federal de Sao Carlos - UFSCar, Sorocaba
%
%  Disciplina: Aprendizado de M�quina
%  Prof. Tiago A. Almeida
%
%  Projeto Aprendizado de Máquina - Shelter Animal Outcomes ( www.kaggle.com )
%
%  Instrucoes
%  ----------
%
%  
%
%  
%

%% Initialization
clear all; close all; clc;

%% Load the train dataset as well as the test dataset 
fprintf('Carregando os dados...\n\n');
[ train_data, test_data ] = readData();

% Displays the menu options and gets back the user's answer
menu_resp = menu();


displayColumnData( menu_resp, train_data );


%% Functions' calls to normalize the datasets
fprintf('Normalizando os dados...\n\n\n');
% with name == 1 and without name == 0
names_arr = normalizeNames( train_data{2} );


% with dog == 1 and cat == 0
animal_type_arr = normalizeAnimalType( train_data{6} );




