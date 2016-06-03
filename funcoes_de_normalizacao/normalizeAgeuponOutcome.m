function [ idadeNormalizada ] = normalizeAgeuponOutcome( idadeTexto )
% [ idadeInteiros ] = normalizeAgeuponOutcome( idadeTexto )
%
% Transforma a idade em texto para idade em inteiros
% E normaliza por padronizacao (media = 0, variancia = 1)
%
%
% UFSCar BCC 2016-1 - Aprendizado de Maquina - Projeto Classificadores (Kaggle)
% Filipe Santos Rocchi - 552194
% Lucas Lukasavicus Silva - 552321
% Marcos Cavalcante - 408336
% Rafael Brandao Barbosa Fairbanks - 552372

% troca as celulas sem valor para 0 days
idadeTexto(cellfun(@isempty, idadeTexto)) = {'0 days'};

% troca paralavras por valores correspondentes na string
idadeTexto = strrep( idadeTexto, 'years', '365' );
idadeTexto = strrep( idadeTexto, 'year', '365' );
idadeTexto = strrep( idadeTexto, 'months', '30' );
idadeTexto = strrep( idadeTexto, 'month', '30' );
idadeTexto = strrep( idadeTexto, 'weeks', '7' );
idadeTexto = strrep( idadeTexto, 'week', '7' );
idadeTexto = strrep( idadeTexto, 'days', '1' );
idadeTexto = strrep( idadeTexto, 'day', '1' );

[nElem, ~] = size(idadeTexto);
idadeNormalizada = zeros(nElem,1);

% para cada celula, le o numero e a base de tempo correspondentes
% e armazena a multiplicacao em idadeNormalizada
for i = 1:nElem
	numBase = sscanf(idadeTexto{i}, '%d %d');
	idadeNormalizada(i,:) = numBase(1) * numBase(2);
end

% normalizacao por padronizacao
idadeNormalizada = zscore(idadeNormalizada);

end
