function [dataset] = loadDataset(dataname)

    N = 60;   % Numero dei valori numerici prima di leggere il target stringa della classe
    dataset = [];
    classi = [];
    cl = {};

    fileid = fopen(dataname);

    while ~feof(fileid)
        d = fscanf(fileid, '%f,', N);
        c = fscanf(fileid, '%s', 1);
        dataset = [dataset, d];   % aggiorno di volta in volta il dataset aggiungendo il valore numerico letto nel file
        cl = [cl, c];  % aggiorno di volta in volta il vettore cl aggiungendo la stringa della classe letta nel file
    end


    % One-Hot-Encoding
    for i=1:length(cl)
        val = strcmp(cl(i), 'M');
        classi = [classi, val];
    end    

    dataset = dataset';

    % Aggiorno il dataset aggiungendo nell'ultima colonna il target numerico
    for i=1:length(dataset(:,1))
        dataset(i,N+1) = classi(i);
    end

    fclose(fileid);
end

        