function logisticaDoida( train_data )
%% TO DO
% futuramente acrescentar os valores de lambda na chamada da funcao
% chamaLogistica pra usar o gridSearch

%% inicializacao
% fprintf('logisticaDoida\n'); % debug, ou nao

% todas colunas usam dummyvar (futuramente isso vai mudar (acho))

animalType = dummyvar(train_data(6));
sexuponOutcome = dummyvar(train_data(7));
ageuponOutcome = dummyvar(train_data(8));
breed = dummyvar(train_data(9));
color = dummyvar(train_data(10));

outcomeType = dummyvar(train_data(4));

% junta tudo numa unica variavel
relevantVariables = [animalType'; sexuponOutcome'; ageuponOutcome'; breed'; color']';
fprintf('tamanho das variaveis relevantes como binarios (colunas)\n');
disp(size(relevantVariables));

fprintf('size outcomeType\n');
disp(size(outcomeType));

fprintf('pressione enter para executar a regressao logistica com esse numero de atributos(colunas)\n');
pause;

%% chamada da funcao de fato

% estava usando todas, mas a 2481 tinha problemas, eh so mudar aqui depois
% pra usar todas de novo
chamaLogistica(relevantVariables(1:2480,:), outcomeType(1:2480,1));
pause;
%chamaLogistica(relevantVariables, outcomeType(:,2));
%chamaLogistica(relevantVariables, outcomeType(:,3));
%chamaLogistica(relevantVariables, outcomeType(:,4));
%chamaLogistica(relevantVariables, outcomeType(:,5));


end

