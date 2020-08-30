clear all
close all
clc


% Caricamento dataset 
dataname = 'sonar-all-data.txt';
dataset = loadDataset(dataname);


% Percentuali per la cardinalità del training set (minimo 60%, massimo 90%, a step del 5%) 
perc = 0.6 : 0.05 : 0.9;

% Numero dei k-nearest-neighbors (da 1 a 21 a step di 2)
k = 1 : 2 : 21;

% Target predetti
classiPredette = [];

% Matrice accuratezze
Ac = zeros(10, length(k)); % 10 righe (numero delle esecuzioni) x 11 colonne (numero dei possibili valori di k)

% Matrice specificità
Sp = zeros(10, length(k));

% Matrice sensività
Se = zeros(10, length(k));


% Calcolo della matrice di covarianza del dataset 
for i=1 : size(dataset,1)
    for j=1 : size(dataset,2)-1
        dataUntarget(i,j) = dataset(i,j);
    end
end
covDataset = cov(dataUntarget);


% Variazione della cardinalità del training set
for i=1 : length(perc)
   
  % 10 esecuzioni 
  for j=1 : 10
            
      % Creazione training set e test set
      [trainingSet, testSet] = splitDataset(dataset, perc(i));      
      
      % Vettore contenente le classi corrette del testSet ricavato
      classiCorrette = testSet(:,end);
      classiCorrette = (classiCorrette)';
      
      % Variazione del numero dei k vicini
      for z=1 : length(k)
          
        % Esecuzione classificatore K-Nearest Neighbors  
        classiPredette = KNearestNeighbors(trainingSet, testSet, covDataset, k(z));
        
        
        % Calcolo dell'accuratezza
        mConfusione = matriceConfusione(classiCorrette, classiPredette);
        Ac(j,z)=sum(diag(mConfusione)) / sum(sum(mConfusione)); % il primo sum restituisce la somma di tutte le righe, il secondo fa la somma complessiva
        % nella matrice Ac le righe rappresentano gli indici dei run, mentre le colonne sono gli indici dei k 
        
        % Calcolo della specificità e della sensitività
        TPR = mConfusione(1,1) / (mConfusione(1,1) + mConfusione(1,2));
        TNR = mConfusione(2,2) / (mConfusione(2,1) + mConfusione(2,2));
        Sp(j,z) = TNR;
        Se(j,z) = TPR;
      end      
  end
  
  
    % Grafici
    figure('name','Classificatore K-Nearest Neighbors');
    title(["Cardinalità del Training Set: " perc(i)*100 " % della dimensione del Dataset"]);
    xlabel('k-vicini');
    ylabel('Performance');
    hold on
    
    % Media delle misure di performance sulle 10 esecuzioni
    mediaAccuratezze = mean(Ac);
    mediaSpecificita = mean(Sp);
    mediaSensitivita = mean(Se);
    
    plot(k,mediaAccuratezze,'-rs', k,mediaSpecificita,'-gs', k,mediaSensitivita,'-bs');   
    legend('Accuratezza','Specificità','Sensitività');
end