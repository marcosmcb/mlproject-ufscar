function [ mat ] = eliminateNaN( mat )
	mat( isnan( mat ) ) = 0;
end