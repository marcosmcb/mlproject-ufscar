function [ normalized_matrix ] = binarizeColumn( column )
    
    %{
    sizeC = size(column);
    nameRows = unique( column );
    sizeR = size(nameRows);
    sizeR = sizeR(1);
    sizeC = sizeC(1);
    normalized_matrix = zeros(sizeR, sizeC);
    
    for i=1:sizeC
        for j=1:sizeR
            if(strcmp(column(i), nameRows(j)))
                break;
            end
        end
        vetaux = zeros(sizeR);
        vetaux(j) = 1;
        normalized_matrix(i) = vetaux;
    end
    %}

    normalized_matrix = dummyvar( column );

end
