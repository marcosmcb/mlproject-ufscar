function [X_norm, media, desvio] = normalizarAtributos(X)
%NORMALIZARATRIBUTOS Normaliza os atributos em X 
%   NORMALIZARATRIBUTOS(X) returna uma versao normalizada de X na qual
%   a media de cada atributos eh 0 e o desvio padrao eh 1.
              

media = mean(X);
X_norm = bsxfun(@minus, X, media);

desvio = std(X_norm);
X_norm = bsxfun(@rdivide, X_norm, desvio);

end
