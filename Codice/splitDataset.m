function [trainingSet, testSet] = splitDataset(dataset, perc)

    trainingSet = [];
    testSet = [];
  
    % Labels delle classi
    classi = unique(dataset(:, 61));
    
    % Numero delle classi
    numClassi = length(classi);

    for j = 1:numClassi
	    % Ricerca di tutti gli elementi della classe corrente
	    I = find(dataset(:, end) == classi(j));        
	    % Generazione permutazione randomica degli indici
	    pR = randperm(length(I));        
	    % Numero di elementi da considerare
	    n = round(perc * length(I));        
	    % Seleziona gli elementi pR-esimi che vanno da 1:n in I
	    trainingSet = [ trainingSet; dataset(I(pR(1:n)), 1:61) ];        
	    %Seleziona i restanti elementi per il test set
	    testSet = [ testSet; dataset(I(pR(n+1:end)), 1:61) ];
    end
end

