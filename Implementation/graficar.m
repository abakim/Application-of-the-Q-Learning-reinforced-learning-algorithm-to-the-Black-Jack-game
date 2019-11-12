function graficar()
%     dinero_partidas_ql_old = sum(dinero_partidas_ql);
%     partidas_ql_old = sum(partidas_ql);
%     partidasg_ql_old = sum(partidasg_ql);
%     dinero_partidas_ql_max_old = sum(partidasg_ql);
%     dinero_partidas_azar_old = sum(dinero_partidas_azar);
%     partidas_azar_old = sum(partidas_azar);
%     partidasg_azar_old = sum(partidasg_azar);
%     dinero_partidas_azar_max_old = sum(dinero_partidas_azar_max);
    
    
    % CARGA DE VARIABLES
    
    variables = csvread('variables.csv');
    % [dinero_partidas_ql_max, dinero_partidas_ql, partidasg_ql, partidas_ql, dinero_partidas_azar_max, dinero_partidas_azar, partidasg_azar, partidas_azar, N]
    
    N = variables(401);
    dinero_partidas_ql_max = variables(1:N);
    dinero_partidas_ql = variables(N+1:2*N);
    partidasg_ql = variables(2*N+1:3*N);
    partidas_ql = variables(3*N+1:4*N);
    dinero_partidas_azar_max = variables(4*N+1:5*N);
    dinero_partidas_azar = variables(5*N+1:6*N);
    partidasg_azar = variables(6*N+1:7*N);
    partidas_azar = variables(7*N+1:8*N);
 
%     dinero_partidas_ql_new = sum(dinero_partidas_ql);
%     partidas_ql_new = sum(partidas_ql);
%     partidasg_ql_new = sum(partidasg_ql);
%     dinero_partidas_ql_max_new = sum(partidasg_ql);
%     dinero_partidas_azar_new = sum(dinero_partidas_azar);
%     partidas_azar_new = sum(partidas_azar);
%     partidasg_azar_new = sum(partidasg_azar);
%     dinero_partidas_azar_max_new = sum(dinero_partidas_azar_max);
%     
%     disp('Verificación')
%     dinero_partidas_ql_new == dinero_partidas_ql_old
%     partidas_ql_new == partidas_ql_old
%     partidasg_ql_new == partidasg_ql_old
%     dinero_partidas_ql_max_new == dinero_partidas_ql_max_old
%     dinero_partidas_azar_new == dinero_partidas_azar_old
%     partidas_azar_new == partidas_azar_old
%     partidasg_azar_new == partidasg_azar_old
%     dinero_partidas_azar_max_new == dinero_partidas_azar_max_old
    
    
    x=1:N;

    % Q-LEARNING %
      
    figure('Name','Dinero Máximo vs Cantidad de Juegos')
    plot(x,dinero_partidas_ql_max)
    title('Dinero Máximo vs cantidad de juegos','FontSize', 17)
    xlabel('cantidad de juegos','FontSize', 17)
    ylabel('dinero max','FontSize', 17)
    hold on
%    figure('Name','dinero vs juegos (azar)')
    plot(x,dinero_partidas_azar_max)
%     title('dinero vs juegos (azar)')
    legend('q-learning','azar','FontSize', 17)
    hold off
    
    
    figure('Name','Dinero (median) vs Cantidad de Juegos')
    plot(x,dinero_partidas_ql)
    title('Dinero (median)  vs cantidad de juegos','FontSize', 17)
    xlabel('cantidad de juegos','FontSize', 17)
    ylabel('dinero (median) ','FontSize', 17)
    hold on
%    figure('Name','dinero vs juegos (azar)')
    plot(x, dinero_partidas_azar)
%     title('dinero vs juegos (azar)')
    legend('q-learning','azar')
    hold off
    

    figure('Name','Partidas vs cantidad de juegos')
    plot(x,partidas_ql);
    title('Partidas vs cantidad de juegos','FontSize', 17)
    xlabel('cantidad de juegos','FontSize', 17)
    ylabel('cantidad de partidas','FontSize', 17)
    hold on
%     figure('Name','partidas vs juegos (azar)')
    plot(x,partidas_azar);
%     title('partidas vs juegos (azar)')
    legend('q-learning','azar','FontSize', 17)
    hold off

    figure('Name','Partidas ganadas vs cantidad de juegos')
    plot(x,partidasg_ql);
    title('Partidas ganadas vs cantidad de juegos','FontSize', 17)
    xlabel('cantidad de juegos','FontSize', 17)
    ylabel('cantidad partidas ganadas','FontSize', 17)
    hold on
%     figure('Name','partidas ganadas vs juegos (azar)')
    plot(x,partidasg_azar);
%     title('partidas ganadas vs juegos (azar)')
    legend('q-learning','azar','FontSize', 17)
    hold off
    
    
     % BARRAS
    figure(5)
    dinero_partidas_ql_median = max(dinero_partidas_ql_max);
    partidas_ql_median = max(partidas_ql);
    partidasg_ql_median = max(partidasg_ql);
    
    dinero_partidas_azar_median = max(dinero_partidas_azar);
    partidas_azar_median = max(partidas_azar);
    partidasg_azar_median = max(partidasg_azar);
        
    y = [dinero_partidas_ql_median dinero_partidas_azar_median; partidas_ql_median partidas_azar_median; partidasg_ql_median partidasg_azar_median];
    tags = {'dinero máximo','cantidad de partidas', 'cantidad de partidas gandas' };
    bar(y) 
    set(gca,'XTickLabel',tags,'FontSize', 16);
    legend('q-learning','azar','FontSize', 17)
    
    % BARRAS INDIVIDUALES
    % Dinero
    figure(6)
    y = [dinero_partidas_ql_median; dinero_partidas_azar_median];
    tags = {'Q-learning','Azar'};
    b = bar(y);
    ylabel('Dinero máximo','FontSize', 17);
    set(gca,'XTickLabel',tags,'FontSize', 17);

    
    % Partidas
    figure(7)
    y = [partidas_ql_median ; partidas_azar_median];
    tags = {'Q-learning','Azar'};
    b = bar(y);
    set(gca,'XTickLabel',tags,'FontSize', 17);
    ylabel('Cantidad máxima de partidas','FontSize', 17);

    
    % Partidas ganadas
    figure(8)
    y = [partidasg_ql_median ; partidasg_azar_median];
    tags = {'Q-learning','Azar'};
    b = bar(y);
    set(gca,'XTickLabel',tags,'FontSize', 17);
    ylabel('Cantidad máxima de partidas ganadas','FontSize', 17);

end