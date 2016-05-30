function [ normalized_array ] = tokenizeAndMultiplyTest( cell_str_arr, lengthArr, biggestAge, smallestAge )
    
    % According to this test http://www.dmueller.com/2014/05/18/programming/speed-of-cellfun-in-matlab/
    % The use of a for-loop does not represent a bottleneck in the
    % execution time of the algorithm. 
    %
    % Furthermore, It performs better in
    % more complex functions, as the one shown below.
    
    normalized_array = zeros(lengthArr, 1);
	for idx = 1:lengthArr
        res = sscanf( cell_str_arr{idx} , '%d %d' );
        normalized_array( idx ) = res(1) * res(2);
	end
	
	% Troca os valores maiores que o maximo pelo maximo ( e os menores que o minimo pelo minimo )
	
	indicesMaioresQueOMaximo = find(normalized_array > biggestAge);
	indicesMenoresQueOMinimo = find(normalized_array < smallestAge);
	
	if ~isempty(indicesMaioresQueOMaximo)
		normalized_array(indicesMaioresQueOMaximo) = biggestAge;
	end
	if ~isempty(indicesMenoresQueOMinimo)
		normalized_array(indicesMenoresQueOMinimo) = smallestAge;
	end
	
end