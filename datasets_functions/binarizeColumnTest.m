function [ normalized_matriz ] = binarizeColumnTest( column , trainColumnCell, sex_upon_out_come_arr)

	testColumn = column{1};

	[nAmostrasTeste, ~] = size(testColumn);

	trainUniqueValues = unique(trainColumnCell{1});
	
	[~, nColunas] = size(sex_upon_out_come_arr);
	
	normalized_matriz = zeros(nAmostrasTeste, nColunas);
	
	for i = 1:nAmostrasTeste
		for j = 1:nColunas
			normalized_matriz(i,j) = isequal(testColumn(i), trainUniqueValues(j));
		end
	end
end
