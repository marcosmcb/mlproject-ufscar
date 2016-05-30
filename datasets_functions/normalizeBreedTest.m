function [ normalized_matrizA, normalized_matrizB ] = ...
		normalizeBreedTest( breed_cells, animal_type_arr, breedAtrain, breedBtrain, sizeBreedA, sizeBreedB)
	
    [breed_col_A, breed_col_B ] = strtok(breed_cells, '/');
    
    breed_col_A = breed_col_A{1};
    breed_col_B = breed_col_B{1};
    
    [sizeA, ~] = size(breed_col_A);
    [sizeB, ~] = size(breed_col_B);

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
	
	% data is ready
	
	trainUniqueValuesA = unique(breedAtrain);
	trainUniqueValuesB = unique(breedBtrain);
	
	normalized_matrizA = zeros(sizeA, sizeBreedA);
	normalized_matrizB = zeros(sizeB, sizeBreedB);
	
	for i = 1:sizeA % elementos da base de teste
		for j = 1:sizeBreedA % quantas colunas de binario tem no treino
			normalized_matrizA(i,j) = isequal(breed_col_A(i), trainUniqueValuesA(j));
		end
	end
	
	
	for i = 1:sizeB
		for j = 1:sizeBreedB
			normalized_matrizB(i,j) = isequal(breed_col_B(i), trainUniqueValuesB(j));
		end
	end
end