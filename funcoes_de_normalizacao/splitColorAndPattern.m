function [corBin] = splitColorAndPattern( cor )
% [corBin] = splitColorAndPattern( cor )
%
% Separa cor e padrao, retorna colunas binarias equivalentes as cores e padroes
%
%
% UFSCar BCC 2016-1 - Aprendizado de Maquina - Projeto Classificadores (Kaggle)
% Filipe Santos Rocchi - 552194
% Lucas Lukasavicus Silva - 552321
% Marcos Cavalcante - 408336
% Rafael Brandao Barbosa Fairbanks - 552372

% Padroes e Cores presentes nos dados
padroes = {'Agouti', 'Brindle', 'Calico', 'Merle', 'Point', 'Smoke', 'Tabby', 'Tick', 'Tiger', 'Torbie', 'Tortie', 'Tricolor'};
cores = {'Apricot', 'Black', 'Blue', 'Brown', 'Buff', 'Chocolate', 'Cream', 'Fawn', 'Flame', 'Gold', 'Gray', 'Lilac', 'Liver', 'Lynx', 'Orange', 'Pink', 'Red', 'Ruddy', 'Sable', 'Seal', 'Silver', 'Tan', 'White', 'Yellow'};

% Separa as cores compostas em esquerda e direita
[esquerda, direita] = strtok( cor, '/' );

% Separa as cores dos tons para esquerda e direita
[esquerdaA, esquerdaB] = strtok( esquerda, ' ' );
esquerdaB = strrep(esquerdaB, ' ', '');

direita = strrep(direita, '/', '');
[direitaA, direitaB] = strtok( direita, ' ' );
direitaB = strrep(direitaB, ' ', '');

% Numero de elementos em cada vetor
[nElem, ~] = size(esquerdaA);
[~, nCores] = size(cores);
[~, nPadroes] = size(padroes);

% prealocacao
ehCor = zeros(nElem, nCores);
ehPadrao = zeros(nElem, nPadroes);


% para cada elemento, verifica quais cores e padroes ele possui
for i=1:nElem
	ehCor(i,:) = ehCor(i,:) | strcmp(esquerdaA{i}, cores);
	ehCor(i,:) = ehCor(i,:) | strcmp(esquerdaB{i}, cores);
	ehCor(i,:) = ehCor(i,:) | strcmp(direitaA{i}, cores);
	ehCor(i,:) = ehCor(i,:) | strcmp(direitaB{i}, cores);

	ehPadrao(i,:) = ehPadrao(i,:) | strcmp(esquerdaA{i}, padroes);
	ehPadrao(i,:) = ehPadrao(i,:) | strcmp(esquerdaB{i}, padroes);
	ehPadrao(i,:) = ehPadrao(i,:) | strcmp(direitaA{i}, padroes);
	ehPadrao(i,:) = ehPadrao(i,:) | strcmp(direitaB{i}, padroes);
end

% junta cor e padrao em uma variavel
corBin = [ehCor, ehPadrao];

end
