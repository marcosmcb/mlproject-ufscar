function [animal_type_arr] = normalizeAnimalType( animals )
    
    animal_type_arr = strrep( animals, 'Dog', '1' );
    animal_type_arr = strrep( animal_type_arr, 'Cat', '0' );
    animal_type_arr = logical( str2num( cell2mat(animal_type_arr) ) ); % Keep on using str2num instead of str2double, it doesn't work with the latter
    
end