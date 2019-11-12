function [matriz_recompensas] = iniciar_matriz_recompensas()

matriz_estados=[];
matriz_estados=carga_estados2(); 

filas=size(matriz_estados,1);
columnas=4; %decisiones

matriz_recompensas=zeros(filas,columnas);


    % Se cargan valores a los estados de victoria y pérdida
    if (matriz_recompensas(end-1,:)>=0)
        matriz_recompensas(end-1,:) = [-1000 -1000 -1000 -1000];
        matriz_recompensas(end,:) = [1000 1000 1000 1000];
    end

end