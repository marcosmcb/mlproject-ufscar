function [vals] = getClasses( mat )

	% We transform the class columns (binary vector) into an array of integers and group them,
	% by creating an integer value for each different class
	int_class_arr = bi2de( mat ) ;	
	
	% After grouping, we proceed to count the number of the different classes 
	% And return the probability of each instance
	[classesFrequency, classes] = hist( int_class_arr, unique( int_class_arr ) );

	class_vals = zeros( 5, 2);
	class_vals(:,2) = [ 1, 2, 4, 8, 16 ];

	classesFrequency = classesFrequency ./ size(int_class_arr,1);

	for idx_i=1:5
		for idx_j=1:size(classes,1)
			if class_vals(idx_i,2) == classes(idx_j,1)
				class_vals(idx_i,1) = classesFrequency(idx_j);
			end
		end
	end

	vals = class_vals(5,1);

end

%{

Return_to_owner	 1     0     0     0     0 = 1
Euthanasia	     0     1     0     0     0 = 2
Adoption         0     0     1     0     0 = 4
Transfer         0     0     0     1     0 = 8
Died	         0     0     0     0     1 = 16

%}