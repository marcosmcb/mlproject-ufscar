function [ normalized_array ] = tokenizeAndMultiply( cell_str_arr, lengthArr)
    
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
end