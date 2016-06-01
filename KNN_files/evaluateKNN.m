function [ result,percentage ] = evaluateKNN( results_classes, true_classes )

	%C = intersect( results_classes, true_classes );
	%result = size(C, 1); 
	%percentage = result / size( results_classes, 1);

	% Matrices results_classes and true_classes must have the same size
	[ nRows,nCols ] = size( results_classes );


	sumEqual = 0;
	sumDifferent = 0;

	for idxRow = 1:nRows

		count = 0;
		for idxCol = 1:nCols
			if results_classes(idxRow,idxCol) == true_classes(idxRow,idxCol)
				count = count + 1;
			else
				break;
			end
		end
		
		if count == nCols
			sumEqual = sumEqual + 1;
		else
			sumDifferent = sumDifferent + 1;
		end
	end


	result = sumEqual;
	percentage = sumEqual/nRows;

end