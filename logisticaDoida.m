function logisticaDoida( train_data )
%% TO DO
% futuramente acrescentar os valores de lambda na chamada da funcao
% chamaLogistica pra usar o gridSearch

%% inicializacao
% fprintf('logisticaDoida\n'); % debug, ou nao

lambda = 1; % ainda nao eh passado pra funcao que faz os calculos

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
%fprintf('Executando a regressao logistica para o primeiro retorno\n');
%[theta, J] = chamaLogistica(relevantVariables(1:2480,:), outcomeType(1:2480,1));

%fprintf('Salvando dados do theta encontrado em arquivo\n');
%save('RL_theta_y1', 'theta');

%chamaLogistica(relevantVariables, outcomeType(:,2));
%chamaLogistica(relevantVariables, outcomeType(:,3));
%chamaLogistica(relevantVariables, outcomeType(:,4));
%chamaLogistica(relevantVariables, outcomeType(:,5));


%% Teste dos resultados

fprintf('Teste dos resultados para a base de treino\n');
fprintf('carregando do arquivo de thetas calculados\n');
load('RL_theta_y1');
disp(size(theta));
% aplica os thetas
resultClassificado_y1 = sigmoid(relevantVariables(1:2480,:) * theta);

%fprintf('resultado da classificacao para y1:\n');
%disp(resultClassificado_y1(1:5,1));
%disp(outcomeType(1:5,1));
disp(size(resultClassificado_y1));
disp(size(theta));

predizer = int8(resultClassificado_y1);
p = mod(predizer,2);

fprintf('calculando taxa de acerto com lambda %d: \n', lambda);
erroMedio = mean(double(p == outcomeType(1:2480,1))) * 100;
disp(erroMedio);

end

