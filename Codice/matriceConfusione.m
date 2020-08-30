function [mConfusione] = matriceConfusione(classiCorrette, classiPredette)

    % Lista dei label
    label = unique(classiCorrette);
    % Numero di classi
    nClassi = length(label);

    % Calcolo della matrice di confusione
    mConfusione = zeros(nClassi, nClassi);
    for i=1 : nClassi
        I = find(classiCorrette==label(i));
        for j=1 : nClassi            
            mConfusione(i, j) = length(find(classiPredette(I)==label(j)));
        end        
    end
end