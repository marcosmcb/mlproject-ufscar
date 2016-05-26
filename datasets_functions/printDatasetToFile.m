function printDatasetToFile( mat, filename, filename_mode )

	fid = fopen( filename, filename_mode );
	for idx = 1:size( mat, 1 )

		if iscell( mat )
			fprintf(fid,'%g\t', mat{idx,:});
		else
	    	fprintf(fid,'%g\t', mat(idx,:));
	    end;
	    
	    fprintf(fid,'\n');
	end
	fclose(fid)

end