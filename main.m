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

%% Inicializacao
clear ; close all; clc

%% ================= Parte 1: Visualizacao dos Dados ====================
%  Muitas vezes a visualizacao dos dados auxilia na interpretacao dos dados
%  e como eles estao distribuidos. Nesta etapa, voce precisa completar a
%  funcao de normalizacao dos atributos (normalizacao.m).
%
fprintf('Carregando os dados...\n\n');
% Carrega dataset de treinamento
train_arq = fopen(fullfile('datasets', 'train.csv'));
train_matrix = textscan( train_arq, '%s%s%s%s%s%s%s%s%s%s', 'delimiter', ',', 'headerlines', 1);









