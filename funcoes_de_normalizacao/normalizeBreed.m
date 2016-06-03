function [ racaBin ] = normalizeBreed( raca, tipoAnimal )
% [ racaNormalizada ] = normalizeBreed( raca, tipoAnimal )
% 
% Faz a normalizacao das racas por separacao e agrupamento
% racaNormalizada eh um vetor binario representando as combinacoes de racas
%
%
% UFSCar BCC 2016-1 - Aprendizado de Maquina - Projeto Classificadores (Kaggle)
% Filipe Santos Rocchi - 552194
% Lucas Lukasavicus Silva - 552321
% Marcos Cavalcante - 408336
% Rafael Brandao Barbosa Fairbanks - 552372

% nota: todos animais possuem raca, caso isso mude, habilite a linha abaixo para substituir as vazias por Unknown
%racaVazios(cellfun(@isempty, raca)) = {'Unknown'};

% numero de elementos
[nElem, ~] = size(raca);

% separa as amostras com mais de uma raca separada por barra
[racaA, racaB] = strtok(raca, '/');

% remove a barra dos nomes de racaB (praticamente nao necessario, mas fica bonito)
racaB = strrep(racaB, '/', '');

% prealoca resultados parciais
racaGrupoA = {zeros(nElem, 1)};
racaGrupoB = {zeros(nElem, 1)};

% chama funcao que agrupa
for i = 1:nElem
	if( tipoAnimal(i) )
		racaGrupoA(i,:) = breed2group( char( racaA(i) ) );
		racaGrupoB(i,:) = breed2group( char( racaB(i) ) );
	else
		racaGrupoA(i,:) = racaA(i);
		racaGrupoB(i,:) = racaB(i);
	end
end

% transforma as racas agrupadas em colunas binario
racaBinA = dummyvar( grp2idx( racaGrupoA ) );
racaBinB = dummyvar( grp2idx( racaGrupoB ) );

% substitui os valores nulos
racaBinB(isnan(racaBinB)) = 0;

% junta numa unica variavel
racaBin = [racaBinA, racaBinB];

end