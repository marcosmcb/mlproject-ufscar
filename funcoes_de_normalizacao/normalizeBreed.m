function [ racaBin ] = normalizeBreed( raca, tipoAnimal )
% [ racaNormalizada ] = normalizeBreed( raca, tipoAnimal )
% 
% Faz a normalizacao das racas por separacao
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

racaGrupoA = zeros(nElem, 1);
racaGrupoB = zeros(nElem, 1);

for i=1:nElem
	if( tipoAnimal(i) )
		racaGrupoA(i) = breed2group( char( racaA(i) ) );
	end
end

for i=1:Elem
	if( tipoAnimal(i) )
		racaGrupoB(i) = breed2group( char( racaB(i) ) );
	end
end

racaBinA = dummyvar( grp2idx( racaGrupoA ) );
racaBinB = dummyvar( grp2idx( racaGrupoB ) );

racaBin = [racaBinA, racaBinB];

pause;

%% Codigo antigo
	%{

    [breed_col_A, breed_col_B ] = strtok(raca, '/');
    
    breed_col_A = breed_col_A{1};
    breed_col_B = breed_col_B{1};
    
    sizeA = size(breed_col_A,1);
    sizeB = size(breed_col_B,1);

	for i=1:sizeA
        if( animal_type_arr(i) )
            breed_col_A(i) = breed2group( char( breed_col_A(i) ) );
        end
	end
    
	for i=1:sizeB
        if( animal_type_arr(i) )
            breed_col_B(i) = breed2group( char( breed_col_B(i) ) );
        end
	end
	
    breed_arr1 = dummyvar( grp2idx( breed_col_A ) );
    breed_arr2 = dummyvar( grp2idx( breed_col_B ) );
	
	breedA_preDummy = breed_col_A;
	breedB_preDummy = breed_col_B;
%}

end