function [color pattern] = splitColorAndPattern( colorAndPattern_arr )
    
    patterns = {'Agouti', 'Brindle', 'Calico', 'Merle', 'Point', 'Smoke', 'Tabby', 'Tick', 'Tiger', 'Torbie', 'Tortie', 'Tricolor'};
    colors = {'Apricot', 'Black', 'Blue', 'Brown', 'Buff', 'Chocolate', 'Cream', 'Fawn', 'Flame', 'Gold', 'Gray', 'Lilac', 'Liver', 'Lynx', 'Orange', 'Pink', 'Red', 'Ruddy', 'Sable', 'Seal', 'Silver', 'Tan', 'White', 'Yellow'};
    
    [Left Right] = strtok( colorAndPattern_arr, '/' );
    
    [LeftA LeftB] = strtok( Left, ' ' );
    LeftA = LeftA{1};
    LeftB = LeftB{1};
    LeftB = strrep(LeftB, ' ', '');
    
    Right = Right{1};
    Right = strrep(Right, '/', '');
    [RightA RightB] = strtok( Right, ' ' );
    RightB = strrep(RightB, ' ', '');
        
    sizeN = size(LeftA,1);
    sizeC = size(colors,2);
    sizeP = size(patterns,2);
    
    color = zeros(sizeN, sizeC);
    pattern = zeros(sizeN, sizeP);
    c_aux = zeros(1,sizeC);
    
    for i=1:sizeN
        c_aux = ismember(colors, LeftA(i));
        color(i,:) = c_aux | color(i,:);
        c_aux = ismember(colors, LeftB(i));
        color(i,:) = c_aux | color(i,:);
        c_aux = ismember(colors, RightA(i));
        color(i,:) = c_aux | color(i,:);
        c_aux = ismember(colors, RightB(i));
        color(i,:) = c_aux | color(i,:);
    end
    
    c_aux = zeros(1,sizeP);
    
    for i=1:sizeN
        c_aux = ismember(patterns, LeftA(i));
        pattern(i,:) = c_aux | pattern(i,:);
        c_aux = ismember(patterns, LeftB(i));
        pattern(i,:) = c_aux | pattern(i,:);
        c_aux = ismember(patterns, RightA(i));
        pattern(i,:) = c_aux | pattern(i,:);
        c_aux = ismember(patterns, RightB(i));
        pattern(i,:) = c_aux | pattern(i,:);
    end
    
end