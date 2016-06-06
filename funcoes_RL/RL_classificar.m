function RL_classificar( testData, nColAlvo )
% RL_CLASSIFICAR ( testDataset, nColAlvo )
%
% Classifica a base de teste
%
%
% UFSCar BCC 2016-1 - Aprendizado de Máquina - Projeto Classificadores (Kaggle)
% Filipe Santos Rocchi - 552194
% Lucas Lukasavicus Silva - 552321
% Marcos Cavalcante - 408336
% Rafael Brandao Barbosa Fairbanks - 552372


tic
%% Variaveis

% carrega a variavel necessaria do arquivo (os thetas)
load('./resultados_RL/parametrosEresultadosTreinoGeral.mat', 'thetas');

[nLin, ~] = size(testData);

dadosClassificados = zeros(nLin, nColAlvo);


%% Adição de Atributos Polinomiais para uso dos thetas

testData = RL_atributosPolinomiais(testData, 0);


%% Classifica a base de teste

for iColAlvo = 1:nColAlvo

	% Classifica as colunas usando os thetas
	dadosClassificados(:, iColAlvo) = RL_sigmoid( testData * thetas(:, iColAlvo) );

end

%% Salva os resultados no arquivo

nomeArquivo = '.\resultados_RL\testdataClassificadoRL.csv';

fid = fopen(nomeArquivo, 'w');
fprintf(fid, 'ID,Adoption,Died,Euthanasia,Return_to_owner,Transfer\n');
fclose(fid);

% Id | Return_to_owner | Euthanasia | Adoption | Transfer | Died

ids(:,1) = 1:nLin;
dadosSalvarArquivo = [ ids, dadosClassificados ];

dlmwrite(nomeArquivo, dadosSalvarArquivo, '-append', 'precision', '%g', 'delimiter', ',');

fprintf('Base de teste classificada, classes salvas no arquivo: testdataClassificadoRL\n');
toc

end

