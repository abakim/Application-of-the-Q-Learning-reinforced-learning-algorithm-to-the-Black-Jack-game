function [salir,mazo,dinero,barajador,recorrido_filas_recompenzas, recorrido_columnas_recompenzas, cartas_j, cartas_b,apuesta,apuesta_doble,decision,estado_q,estado_siguiente,accion_resultante,estados_1,fin_juego,suma_total_j,blackjack,cant_cartas_j,dinero_disponible,separar_disponible,as_disponible,partida, partidas_ganadas, recompenza, cuenta_mezcla,matriz_estados, dinero_partidas, contadores_blackjack, epsilon, matriz_recompensas] = comienzo_partida(salir,mazo,dinero,barajador,recorrido_filas_recompenzas, recorrido_columnas_recompenzas, cartas_j, cartas_b,apuesta,apuesta_doble,decision,estado_q,estado_siguiente,accion_resultante,estados_1,fin_juego,suma_total_j,blackjack,cant_cartas_j,dinero_disponible,separar_disponible,as_disponible,partida, partidas_ganadas, recompenza, cuenta_mezcla,matriz_estados, dinero_partidas, contadores_blackjack, epsilon, matriz_recompensas)

    if (dinero<100)
    
        disp('Fin de juego. No tiene mas dinero');

        disp('Partidas totales jugadas: ');
        partida

        disp('Dinero conseguido en cada partida: ');
        dinero_partidas

        decision=0;

        fin_juego=1;
        
        salir=5;
       
        
    end
    
    
     if (partida>300)
    
        disp('Se termina el juego por superar el limite maximo de partidas');

        disp('Partidas totales jugadas: ');
        partida

        disp('Dinero conseguido en cada partida: ');
        dinero_partidas

        decision=0;

        fin_juego=1;

        salir=5;
    end
   
    
    if (salir==0)
        
    % mezcla
    
        if (cuenta_mezcla==10)
        
        disp('Mezcla de cartas');
       
        barajador=[mazo mazo mazo mazo];
        cuenta_mezcla=0;
        
        end
    
    
    
    

    % inicializaciones
    
    disp('');  
    disp('-------------------------------p--------------------------------------');  
    disp('');  

    partida=partida+1; % incremento partida
    
    disp('Comienzo de partida: ');
    partida
    
    recorrido_filas_recompenzas=[];
    recorrido_columnas_recompenzas=[];
    
    cuenta_mezcla=cuenta_mezcla+1;
      
    cartas_j=[];
    
    cartas_b=[];
    
    apuesta=100; % apuesta inicial
    
    apuesta_doble=0;
    
    decision=0;
    
    estado_q=0;
    estado_siguiente=0;
    
    accion_resultante = 0;
    
    estados_1 = [0 0 0 0 0 0];
    

    % repartida inicial    

    pos_carta_sacada=randperm(length(barajador),1);

    cartas_j(end+1)=barajador(pos_carta_sacada);

    barajador(pos_carta_sacada)=[];
    
    

    pos_carta_sacada=randperm(length(barajador),1);

    cartas_b(end+1)=barajador(pos_carta_sacada);

    barajador(pos_carta_sacada)=[];


    
    pos_carta_sacada=randperm(length(barajador),1);

    cartas_j(end+1)=barajador(pos_carta_sacada);
    
    barajador(pos_carta_sacada)=[];


    
    pos_carta_sacada=randperm(length(barajador),1);

    cartas_b(end+1)=barajador(pos_carta_sacada);

    barajador(pos_carta_sacada)=[];

    
    suma_total_j=sum(cartas_j);
    
    disp('');
    disp('Dinero en bolsillo:');
    dinero
    
    disp('');
    disp('recompenza: ');
    recompenza
    
    
    dinero_partidas(end+1)=dinero;
	
    
	% Blackjack
	
	if ( (suma_total_j==21) && (length(cartas_j)==2) ) 

        disp('');
        disp('Black Jack jugador:');

        contadores_blackjack=contadores_blackjack+1;

        blackjack=1;
        decision=2;
        accion_resultante=2;
        

        
        %-------------------------------------------------------%
        
        % cargo estados
        
        cant_cartas_j=length(cartas_j);
        
        if (dinero>=200)
            dinero_disponible=1;
        end
        
        if (dinero<200)
            dinero_disponible=0;
        end
        
        if (cartas_j(1)==cartas_j(2))
           separar_disponible=1;
        end
        
        if (cartas_j(1)~=cartas_j(2))
           separar_disponible=0;
        end
        
        pos_as=find(cartas_j==11);
        
        if (not(isempty(pos_as)))
        as_disponible=1;
        end
        
        if (isempty(pos_as))
        as_disponible=0;
        end
        
        estados_1=[suma_total_j,cant_cartas_j,separar_disponible,dinero_disponible,as_disponible,cartas_b(1)];
      
        % matriz_estados

        
        estado_q=find(ismember(matriz_estados,estados_1,'rows')==1); % posicion fila
        
        
       
    end

	
	
	% comportamiento As
	
    pos=find(cartas_j==11);
    
	if ( (not(isempty(pos))) && (suma_total_j>21) ) 

        cartas_j(pos)=1;
        
        % Verifico si hay otro as
        
        pos=find(cartas_j==11);
    
        if ( (not(isempty(pos))) && (length(cartas_j)==2) )  

                cartas_j(pos)=1;

        end
        
        suma_total_j=sum(cartas_j);
	
    end
    
            salir=2;
    end
    % decisiones
    
        
    %pause(delay); 
    
    
end
