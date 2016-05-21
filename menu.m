function menu_choice = menu()
    
    fprintf('Escolha um dos atributos listados para exibir as suas respectivas frequências\n');
    fprintf('\t 1- AnimalID\n\n');
    fprintf('\t 2- Name\n\n');
    fprintf('\t 3- DateTime\n\n');
    fprintf('\t 4- OutcomeType\n\n');
    fprintf('\t 5- OutcomeSubType\n\n');
    fprintf('\t 6- AnimalType\n\n');
    fprintf('\t 7- SexuponOutcome\n\n');
    fprintf('\t 8- AgeuponOutcome\n\n');
    fprintf('\t 9- Breed\n\n');
    fprintf('\t 10- Color\n\n');

    menu_choice = input( 'Informe um valor entre 1 .. 9\n\n' );

end