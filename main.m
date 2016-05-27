%% Universidade Federal de Sao Carlos - UFSCar, Sorocaba
%
%  Disciplina: Aprendizado de Maquina
%  Prof. Tiago A. Almeida
%
%  Projeto Aprendizado de Máquina - Shelter Animal Outcomes ( www.kaggle.com )
%
%
%


%% Initialization
clear; close all; clc;

%% Adding needed subfolders to path
addpath('./datasets_functions'); % funcoes de tratamento de dados
addpath('./RedesNeurais'); % funcao de redes neurais

%% Load the train dataset as well as the test dataset 
fprintf('Carregando os dados do dataset [sem normalizacao] ...\n\n');
[ train_data, test_data ] = readData();

%% Displays the menu options and gets back the user's answer
menu(train_data, test_data);

%% Exiting
fprintf('\n[Programa Finalizado]\n');
%clear; close all; % removido para testes, decidir sobre mudar depois
