function [tPred] = KNearestNeighbors(trainingSet, testSet, covDataset, k)

    tPred = [];
    covDataset = inv(covDataset);
    
    % Ricerca delle distanze tra gli elementi del test set e gli elementi del training set al fine di stabilire i k vicini    
    for i=1 : size(testSet,1)          
        for j=1 : size(trainingSet,1)
            % Calcolo della distanza, dove nella prima colonna vengono inserite le distanze tra l'i-esimo elemento del test set e tutti gli elementi del training set
            X = (testSet(i,1:end-1))';
            Y = (trainingSet(j,1:end-1))';
            dist(j,1) = sqrt((X-Y)' * covDataset * (X-Y));
            
            % La seconda colonna contiene le informazioni inerenti la classe del j-eseimo elemento del training set
            dist(j,2) = trainingSet(j,end);
        end
        
        % Ordinamento del vettore dist in base al valore delle distanze ottenute
        dist = sortrows(dist,1);
        
        % Conteggio delle k classi aventi le distanze minori
        count = sum(dist(1:k,2),1);
        
        % Valori predetti
        tPred = [tPred, round(count/k)]; % Esempio: count=1+1+0, k=3 --> round(2/3) = round(0.6666) = 1;
    end
end