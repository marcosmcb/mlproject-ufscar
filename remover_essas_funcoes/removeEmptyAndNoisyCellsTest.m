function [ data_arr ] = removeEmptyAndNoisyCellsTest( empty_arr, zeros_arr, data_arr, biggestAge, smallestAge )
tic;
    data_arr = data_arr( empty_arr );
    data_arr( zeros_arr ) = [];
	
	data_arr = find(data_arr < smallestAge);
	data_arr = find(data_arr > biggestAge);
	
	
	
toc;
pause;
end