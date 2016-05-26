function printDatasetToFile( mat, mat_colour, mat_breed, mat_colour_breed )

	fprintf('Imprindo DataSets gerados na pasta: datasets_normal&clean ...\n\n');
    dlmwrite('../datasets_normal&clean/datasetNormalAndClean.mat', mat);
    dlmwrite('../datasets_normal&clean/datasetNormalAndCleanColours.mat', mat_colour);
    dlmwrite('../datasets_normal&clean/datasetNormalAndCleanBreeds.mat', mat_breed);
    dlmwrite('../datasets_normal&clean/datasetNormalAndCleanColoursAndBreeds.mat', mat_colour_breed);

end