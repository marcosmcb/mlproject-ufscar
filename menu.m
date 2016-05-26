function menu( train_data, train_dataset_normalized )
    
    fprintf(' Exibindo menu das operacoes sobre a base de dados \n\n');
    resp = input('Deseja Visualizar estatisticas sobre os dados ? [ 1-Sim 0-Nao ]\n\n');

    if ( resp )

        fprintf( 'Estatisticas sendo executadas sobre a base de dados crua \n\n' );
        getStatistics( train_data );

    end;

    resp = input('Deseja executar o algoritmo KNN? [ 1-Sim 0-Nao ]\n\n');

    if ( resp )

        resp = input('Deseja visulizar os dados gerados pelo KNN? [1-Sim 0-Nao]\n\n');
        
        if( resp )

        end;

    end;


    resp = input('Deseja executar o algoritmo Regressao Logistica? [ 1-Sim 0-Nao ]\n\n');

    if ( resp )

        resp = input('Deseja visulizar os dados gerados pela Regressao Logistica? [1-Sim 0-Nao]\n\n');
        
        if( resp )

        end;

    end;

    resp = input('Deseja executar o algoritmo SVM? [ 1-Sim 0-Nao ]\n\n');

    if ( resp )

        resp = input('Deseja visulizar os dados gerados pela SVM? [1-Sim 0-Nao]\n\n');
        
        if( resp )

        end;

    end;
    
    resp = input('Deseja executar o algoritmo Rede Neural Artificial? [ 1-Sim 0-Nao ]\n\n');

    if ( resp )

        resp = input('Deseja visulizar os dados gerados pela Rede Neural Artificial? [1-Sim 0-Nao]\n\n');
        
        if( resp )

        end;

    end;



end