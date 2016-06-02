function RL_classificar( testDataset )
% RL_CLASSIFICAR ( testDataset )
%   Classifica a base de teste

load('./RL_results/RL_numFolds5_normalGS.mat');

idxLambda = find(RL_lambdas == 0.005);

[nLin, ~] = size(testDataset);

% Calculo das classes
evalResults(:,1) = 1:nLin;
evalResults(:,2:6) = RL_sigmoid(testDataset * RL_thetasMatrix(1:114,:,idxLambda));

filename = 'submissionMLGROUP7_AM.csv';

fid = fopen(filename, 'w');
fprintf(fid, 'ID,Adoption,Died,Euthanasia,Return_to_owner,Transfer\n');
fclose(fid);

% Id|Return_to_owner | Euthanasia | Adoption | Transfer | Died

printResults(:,1) = evalResults(:,1);
printResults(:,2) = evalResults(:,4);
printResults(:,3) = evalResults(:,6);
printResults(:,4) = evalResults(:,3);
printResults(:,5) = evalResults(:,2);
printResults(:,6) = evalResults(:,5);

dlmwrite(filename, printResults, '-append', 'precision', '%g', 'delimiter', ',');


end

