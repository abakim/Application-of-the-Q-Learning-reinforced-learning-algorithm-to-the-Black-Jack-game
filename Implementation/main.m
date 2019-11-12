function [matriz_recompensas, partidasg_ql_median, partidasg_azar_median,partidas_ql_median, partidas_azar_median, dinero_partidas_ql_median_t, dinero_partidas_azar_median_t] = main()
% PARA CARGAR LA MATRIZ %
matriz_recompensas = csvread('matriz_entrenada.csv');

% PARA GUARDAR LA MATRIZ %
% csvwrite('database.csv',matriz_recompensas)

% PARA AUMENTAR LA RECURSIÓN %
% set(0,'RecursionLimit',700)   


    % Inicializaciones
    partidasg_ql = [];   % promedio de partidas ganadas con qlearning
    partidasg_azar = []; % promedio de partidas ganadas produciendo acciones al azar
    partidas_ql = [];    % cantidad de partidas con qlearning
    partidas_azar = [];  % cantidad de partidas produciendo acciones al azar
    dinero_partidas_ql = [];
    dinero_partidas_azar = [];
    dinero_partidas_ql_max = [];
    dinero_partidas_azar_max = [];
    partidasg_ql_median = 0;
    partidasg_azar_median = 0;
    partidas_ql_median = 0;
    partidas_azar_median = 0;
    dinero_partidas_ql_median_t = 0;
    dinero_partidas_azar_median_t = 0;
    
    
    
    % *** PARTIDAS CON Q-LEARNING *** %
    
% Para entrenamiento medio epsilon: 0.3:-0.01:0.1 
N= 50;
    for i=1:N
            [matriz_recompensas,partidasg_aux, partidas_aux, dinero_partidas_aux] = bj_main(matriz_recompensas,0);
              partidasg_ql = [partidasg_ql partidasg_aux];
              partidas_ql = [partidas_ql partidas_aux];
              dinero_partidas_ql = [dinero_partidas_ql median(dinero_partidas_aux)];
              dinero_partidas_ql_max = [dinero_partidas_ql_max max(dinero_partidas_aux)];
    end
    
%     N= length(0.3:-0.01:0.1);

    dinero_partidas_ql_max_t = median(dinero_partidas_ql_max);    
    dinero_partidas_ql_median_t = median(dinero_partidas_ql);
    partidasg_ql_median = median(partidasg_ql);
    partidas_ql_median = median(partidas_ql);

   
    
    % *** PARTIDAS CON DECISIÓN AL AZAR *** %
    for i=1:N   % itera la misma cantidad de veces que qlearning (en uso)
        [partidasg_aux2, partidas_aux2, dinero_partidas_aux2] = bj_main_azar();
        partidasg_azar = [partidasg_azar partidasg_aux2];
        partidas_azar = [partidas_azar partidas_aux2];
        dinero_partidas_azar = [dinero_partidas_azar median(dinero_partidas_aux2)]; % REEMPLAZAR POR MEAN
        dinero_partidas_azar_max = [dinero_partidas_azar_max max(dinero_partidas_aux2)];
    end

       dinero_partidas_azar_max_t = median(dinero_partidas_azar_max);
       dinero_partidas_azar_median_t = median(dinero_partidas_azar);
       partidas_azar_median = median(partidas_azar);
       partidasg_azar_median = median(partidasg_azar);
       
       % Guardado de variables
       csvwrite('variables.csv',[dinero_partidas_ql_max, dinero_partidas_ql, partidasg_ql, partidas_ql, dinero_partidas_azar_max, dinero_partidas_azar, partidasg_azar, partidas_azar, N]);
      
%        graficar(dinero_partidas_ql, partidas_ql, partidasg_ql, dinero_partidas_ql_max, dinero_partidas_azar, partidas_azar, partidasg_azar, dinero_partidas_azar_max, N);    % grafica estadísticas
      
end