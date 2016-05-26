function [ output_args ] = SVM_init( trainData, targetData )
%% Metodo de classificacao usando SVM
% essa funcao usa a libSVM, interface para treinamento com SVM
% disponivel em: http://www.csie.ntu.edu.tw/~cjlin/libsvm

% >> svmtrain
% mostra o help


%% configuracao de parametros

%% chamada da funcao para testes (remover depois)
labels = double(rand(10,1)>0.5);
data = rand(10,5);
model = svmtrain(labels, data, '-s 0 -t 2 -c 1 -g 0.1');

% IT WORKS MUAHAHAHAHAHA

%% gridSearch da chamada da funcao

bestcv = 0;

for log2c = -1:3, % alterar a range (C)
  for log2g = -4:1, % alterar a range (gamma)
      % -s 0 : SVM tipo C-SVC
      % -t 0 : kernel tipo linear
      % -v 5 : n-fold cross validation (80-20)
      % -c X : multiplicador do erro (overfitting alert!!)
      % -g X : gamma, controla as bias e a variancia nos modelos (> > < | < < >)
    cmd = ['-s 0 -t 0 -v 5 -c ', num2str(2^log2c), ' -g ', num2str(2^log2g)]; % opcoes
    cv = svmtrain(trainData, targetData, cmd);
    if (cv >= bestcv),
      bestcv = cv; bestc = 2^log2c; bestg = 2^log2g;
    end
    fprintf('%g %g %g (best c=%g, g=%g, rate=%g)\n', log2c, log2g, cv, bestc, bestg, bestcv);
  end
end

%% salvar resultados

end
