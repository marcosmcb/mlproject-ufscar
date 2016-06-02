%% Universidade Federal de Sao Carlos - UFSCar, Sorocaba
%
%  Disciplina: Aprendizado de Maquina
%  Prof. Tiago A. Almeida
%
%  Projeto Aprendizado de Maquina - Shelter Animal Outcomes ( www.kaggle.com )
%
%
% Filipe Santos Rocchi - 552194
% Lucas Lukasavicus Silva - 552321
% Marcos Cavalcante - 408336
% Rafael Brandao Barbosa Fairbanks - 552372

%% Inicializacao

clear; close all; clc;

%% Adicionando pastas necessarias ao path do MATLAB

addpath('./funcoes_de_normalizacao/'); % funcoes de tratamento de dados
addpath('./funcoes_KNN'); % funcoes de KNN
addpath('./funcoes_RL'); % funcoes de RL
addpath('./funcoes_RNA'); % funcoes de RNA
addpath('./funcoes_SVM'); % funcoes de SVM


%% Carregamento e Normalizacao dos dados (se necessario)

existeDadosProcessados = exist('normalized_data.mat', 'file');

resposta = 0;

if existeDadosProcessados
	fprintf('Dados normalizados encontrados em arquivo.\n[1] - Carregar dados normalizados\n[2] - Renormalizar dados');
	resposta = input('> ');
end

if resposta == 1
	% carrega os dados normalizados
	load('processed_data.mat');
end

if  ~existeDadosProcessados || resposta == 2
	% carrega os dados originais
	[trainData, testData] = readData();
	% normaliza os dados
	[trainDatasetNormalized, testDatasetNormalized] = normalizeDataset(trainData, testData);
end


%% Menu de opcoes dos algoritmos

menu(trainDatasetNormalized, testDatasetNormalized);


%% Mensagem de termino

fprintf('\n[Programa Finalizado]\n');
