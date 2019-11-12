function  [salir,mazo,dinero,barajador,recorrido_filas_recompenzas, recorrido_columnas_recompenzas, cartas_j, cartas_b,apuesta,apuesta_doble,decision,estado_q,estado_siguiente,accion_resultante,estados_1,fin_juego,suma_total_j,blackjack,cant_cartas_j,dinero_disponible,separar_disponible,as_disponible,partida, partidas_ganadas, recompenza, cuenta_mezcla,matriz_estados, dinero_partidas, contadores_blackjack, epsilon, matriz_recompensas  ] = toma_decisiones(salir,mazo,dinero,barajador,recorrido_filas_recompenzas, recorrido_columnas_recompenzas, cartas_j, cartas_b,apuesta,apuesta_doble,decision,estado_q,estado_siguiente,accion_resultante,estados_1,fin_juego,suma_total_j,blackjack,cant_cartas_j,dinero_disponible,separar_disponible,as_disponible,partida, partidas_ganadas, recompenza, cuenta_mezcla,matriz_estados, dinero_partidas, contadores_blackjack, epsilon, matriz_recompensas)



    if (dinero<100)
    
        salir=5;
        return;
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
   
    
    
    
    disp('');    
    disp('-------------------------------d--------------------------------------');  
        
    disp('');
    disp('cartas jugador:');
    cartas_j
    
    disp('');
    disp('carta banca:');
    cartas_b(1)
    
    
    recompenza=0;
    
    if (decision==0)
      
    
    
        % Toma de decisiones (1 - pedir, 2 - plantar, 3 - doblar, 4 - dividir)
        

        
        disp('');
        
        %decisiones jugador
        %decision=input('Decision a tomar: ')

		
		
		
        
        
        
		%----------------------------------------------------------------------
		
		% Q-learning

        
    %{
		
        % Con estados 1 (primer planteo problema)
        
        % Las cartas del jugador (elementos 1-5),

        % Si el dinero que posee es igual o mayor a 200 (elemento 6)    

        % La carta del coupier que se ve (elemento 7)

        % cargo estados
        
        l=5-length(cartas_j);
        
        if (dinero>=200)
            dinero_disponible=1;
        end
        
        if (dinero<200)
            dinero_disponible=0;
        end
        
        estados_1=[carta_j,zeros(l),dinero_disponible,cartas_b(1)];
        

        % llamo a decision_agente

       [accion,yval]=decision_agente(estados1,A,neu,T);

    %}

        
        
        
    
		
        % Con estados 2 (segundo planteo problema)
        
        % Suma de las cartas del jugador (elemento 1)

        % Cantidad de cartas de Jugador (elemento 2)

        % Si puede separar o no (elemento 3)

        % Si el dinero que posee es igual o mayor a 200 (elemento 4)

        % Si hay o no un as que no se tiene que usar si o si como 1 (elemento 5)

        % La carta del coupier que se ve (elemento 6)

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
        

               if (isempty(estado_q))
                   salir=5;
                   return;
               end
                    %for i=1:size(matriz_estados,1) % recorro por fila
                    %       if (index_e(i,:) == estado)
                    %          estado_q=i;
                    %     end
                    %end

%-------------------------------------------------
            % Se busca la decisión a tomar
%       maxima_recompenza,accion_resultante] = max(matriz_recompensas(estado_q,:));

%       por cada epoca debe bajar 0.1
            if (rand(1) < epsilon)    % si el rand está debajo del epsilon
                accion_resultante = randperm(4,1);  
            else
                [maxima_recompensa,accion_resultante] = max(matriz_recompensas(estado_q,:));
            end
            
            
            
            
%-------------------------------------------------
        
        recorrido_filas_recompenzas(end+1)=estado_q;
        recorrido_columnas_recompenzas(end+1)=accion_resultante;
        
        
        decision=accion_resultante;
        
    
                
    %    [matriz_recompensas] = qlearning_online(accion_resultante, matriz_estados, estados_1, siguienteEstado, recompenza, matriz_recompensas)
    
        
        
        disp('Decision tomada: ');
		decision
		%----------------------------------------------------------------------
		
		
		
		
		
		
        % validaciones
        
       
        
        if ( (decision==3) && (dinero<200) ) 
            
            decision=0;
            disp('');
            disp('No es posible doblar con la cantidad de dinero disponible');
            matriz_recompensas(estado_q,accion_resultante)= matriz_recompensas(estado_q,accion_resultante)-500;
            
            salir=2; return;
            
        end
        
        
        if ( (decision==4) && (dinero<200) ) 
            
            decision=0;
            disp('');
            disp('No es posible separar con la cantidad de dinero disponible');
            matriz_recompensas(estado_q,accion_resultante)= matriz_recompensas(estado_q,accion_resultante)-500;
            
            salir=2; return;

        end
        
        
        if ( (decision==3) && (length(cartas_j)>2) ) 

            decision=0;
            disp('');
            disp('No se puede doblar ya que tiene mas de dos cartas');
            matriz_recompensas(estado_q,accion_resultante)= matriz_recompensas(estado_q,accion_resultante)-500;

            salir=2; return;

        end


        if ( (decision==4) && ( (cartas_j(1)~=cartas_j(2)) ) ) 
            
            decision=0;
            disp('');
            disp('No se pueden separar cartas debido a que son distintas');
            matriz_recompensas(estado_q,accion_resultante)= matriz_recompensas(estado_q,accion_resultante)-500;
            salir=2; return;

        end


        if ( (decision==4) && (length(cartas_j)~=2) ) 

            decision=0;
            disp('');
            disp('No se pueden separar cartas debido a que tiene mas de dos cartas');
            matriz_recompensas(estado_q,accion_resultante)= matriz_recompensas(estado_q,accion_resultante)-500;
            
            salir=2; return;
        end
        
        
        if ( (decision<1) || (decision>4) )
            
              decision=0;
              disp('');
              disp('Decision no respondiente. Reintente');
              matriz_recompensas(estado_q,accion_resultante)= matriz_recompensas(estado_q,accion_resultante)-500;
              
              salir=2; return;
        end
        
        if (not(isnumeric(decision)))
        
        d_aux=str2num(decision);
        
            if (isempty(d_aux))
            
                  decision=0; 
                  disp('');
                  disp('Decision no respondiente. Reintente');
                  matriz_recompensas(estado_q,accion_resultante)= matriz_recompensas(estado_q,accion_resultante)-500;
                  
                  salir=2; return;
            end    
        end
        

        
    end
    
    
    
    
    % Ejecucion Decisiones
    
    if (decision==1)
        
        decision=0;
        
        pos_carta_sacada=randperm(length(barajador),1);

        cartas_j(end+1)=barajador(pos_carta_sacada);
        
        barajador(pos_carta_sacada)=[];
              
        suma_total_j=sum(cartas_j);
        
        
        
        % verifico as
        
        pos=find(cartas_j==11);
    
        if ( (not(isempty(pos))) && (suma_total_j>21) ) 

        cartas_j(pos)=1;
        
        suma_total_j=sum(cartas_j);
	
        end
        

        
        disp('');
        disp('cartas jugador:');
        cartas_j
    
        
        if (suma_total_j>21)
           
            dinero=dinero-apuesta;
            
            disp('');
            disp('El jugador se paso. Partida perdida');
            
            recompenza=-50;
            
            %q-l
            
            %for p=1:length(recorrido_filas_recompenzas)
            %matriz_recompensas(recorrido_filas_recompenzas(p),recorrido_columnas_recompenzas(p))= matriz_recompensas(recorrido_filas_recompenzas(p),recorrido_columnas_recompenzas(p))+recompenza;
            %end
            
            if ( (not(isempty(recorrido_filas_recompenzas))) )
                
                for p=1:(length(recorrido_filas_recompenzas)-1)
                     [matriz_recompensas] = qlearning_online(recorrido_columnas_recompenzas(p), matriz_estados, matriz_estados(recorrido_filas_recompenzas(p),:), matriz_estados(recorrido_filas_recompenzas(p+1),:), recompenza, matriz_recompensas);
                end
            end
            
            estado_siguiente=[0 0 0 0 0 0];     % estado pérdida
            
            [matriz_recompensas] = qlearning_online(accion_resultante, matriz_estados, estados_1, estado_siguiente, recompenza, matriz_recompensas);
            
            salir=0; return; % reinicio    
        end
        
        
        estado_siguiente=[suma_total_j,cant_cartas_j,separar_disponible,dinero_disponible,as_disponible,cartas_b(1)]; 
        [matriz_recompensas] = qlearning_online(accion_resultante, matriz_estados, estados_1, estado_siguiente, recompenza, matriz_recompensas);
        
        salir=2; return;
    end
    
    
    
    
     if (decision==2)
        
        suma_total_b=sum(cartas_b);
        
        decision=0;
		
		%blackjack
		
		if ( (suma_total_b==21) && (length(cartas_b)==2) ) 
		
			disp('');
			disp('Black Jack banca:');
			cartas_b
			
				if (blackjack==1)
				
					blackjack=0;
					disp('');
					disp('Empate:');
					salir=0; return; % reinicio
			
                end
				
			dinero=dinero-apuesta;
			disp('');
			disp('Partida Perdida:');
            
            recompenza=-50;
            
            %q-l
            
            %for p=1:length(recorrido_filas_recompenzas)
            %matriz_recompensas(recorrido_filas_recompenzas(p),recorrido_columnas_recompenzas(p))= matriz_recompensas(recorrido_filas_recompenzas(p),recorrido_columnas_recompenzas(p))+recompenza;
            %end
            
            if ( (not(isempty(recorrido_filas_recompenzas))) )
                for p=1:(length(recorrido_filas_recompenzas)-1)
                    [matriz_recompensas] = qlearning_online(recorrido_columnas_recompenzas(p), matriz_estados, matriz_estados(recorrido_filas_recompenzas(p),:), matriz_estados(recorrido_filas_recompenzas(p+1),:), recompenza, matriz_recompensas);
                end
            end
            estado_siguiente=[0 0 0 0 0 0];
            
            [matriz_recompensas] = qlearning_online(accion_resultante, matriz_estados, estados_1, estado_siguiente, recompenza, matriz_recompensas);
			
            
            
			salir=0; return; % reinicio
			
        end
        
        
		
		if (blackjack==1)
            
            % Partida ganada
		
        
            blackjack=0;
            dinero= dinero + (apuesta * 1.5); 
            partidas_ganadas=partidas_ganadas+1;
            recompenza=80;

        
            %q-l
            
            %for p=1:length(recorrido_filas_recompenzas)
            %matriz_recompensas(recorrido_filas_recompenzas(p),recorrido_columnas_recompenzas(p))= matriz_recompensas(recorrido_filas_recompenzas(p),recorrido_columnas_recompenzas(p))-recompenza;
            %end
            
            
            if ( (not(isempty(recorrido_filas_recompenzas))) )
                for p=1:(length(recorrido_filas_recompenzas)-1)
                    [matriz_recompensas] = qlearning_online(recorrido_columnas_recompenzas(p), matriz_estados, matriz_estados(recorrido_filas_recompenzas(p),:), matriz_estados(recorrido_filas_recompenzas(p+1),:), recompenza, matriz_recompensas);
                end
            end

            estado_siguiente=[1 1 1 1 1 1];
            
            
            [matriz_recompensas] = qlearning_online(accion_resultante, matriz_estados, estados_1, estado_siguiente, recompenza, matriz_recompensas);

            
            salir=0; return; % reinicio
		
        end
		
		
		
		
		
		
		% secuencia normal
		
      
        while (suma_total_b<17)
            
                pos_carta_sacada=randperm(length(barajador),1);

                cartas_b(end+1)=barajador(pos_carta_sacada);

                barajador(pos_carta_sacada)=[];
                
                suma_total_b=sum(cartas_b);
                
                
               % verifico as
        
                pos=find(cartas_b==11);

                if ( (not(isempty(pos))) && (suma_total_b>21) ) 

                    cartas_b(pos)=1;

                    suma_total_b=sum(cartas_b);

                end
        end
        
        disp('');
        disp('cartas banca:');
        cartas_b       
        
        if (suma_total_b>21)
                
                disp('');
                disp('La banca se paso. Partida ganada');
                
                dinero=dinero+apuesta;
                partidas_ganadas= partidas_ganadas +1;
               

                if (apuesta_doble==1)
                    apuesta_doble=0;
                    recompenza=100;
                else
                    recompenza=50;
                end
                
                
                %q-l
            
                %for p=1:length(recorrido_filas_recompenzas)
                %matriz_recompensas(recorrido_filas_recompenzas(p),recorrido_columnas_recompenzas(p))= matriz_recompensas(recorrido_filas_recompenzas(p),recorrido_columnas_recompenzas(p))-recompenza;
                %end
                
                
                if ( (not(isempty(recorrido_filas_recompenzas))) )
                    for p=1:(length(recorrido_filas_recompenzas)-1)
                       [matriz_recompensas] = qlearning_online(recorrido_columnas_recompenzas(p), matriz_estados, matriz_estados(recorrido_filas_recompenzas(p),:), matriz_estados(recorrido_filas_recompenzas(p+1),:), recompenza, matriz_recompensas);
                    end
                end

                estado_siguiente=[1 1 1 1 1 1];
            
                [matriz_recompensas] = qlearning_online(accion_resultante, matriz_estados, estados_1, estado_siguiente, recompenza, matriz_recompensas);

                
                salir=0; return; % reinicio
            
        end
        
        
        
        
        if (suma_total_b>suma_total_j)
        
                disp('');
                disp('Partida perdida');
                        
                dinero=dinero-apuesta;
                
                if (apuesta_doble==1)
                    apuesta_doble=0;
                    recompenza=-100;
                else
                    recompenza=-50;
                end
                
                
                
                %q-l
            
                %for p=1:length(recorrido_filas_recompenzas)
                %matriz_recompensas(recorrido_filas_recompenzas(p),recorrido_columnas_recompenzas(p))= matriz_recompensas(recorrido_filas_recompenzas(p),recorrido_columnas_recompenzas(p))-recompenza;
                %end
                
                
                if ( (not(isempty(recorrido_filas_recompenzas))) )
                    for p=1:(length(recorrido_filas_recompenzas)-1)
                        [matriz_recompensas] = qlearning_online(recorrido_columnas_recompenzas(p), matriz_estados, matriz_estados(recorrido_filas_recompenzas(p),:), matriz_estados(recorrido_filas_recompenzas(p+1),:), recompenza, matriz_recompensas);            
                    end
                end
                
                estado_siguiente=[0 0 0 0 0 0];

                [matriz_recompensas] = qlearning_online(accion_resultante, matriz_estados, estados_1, estado_siguiente, recompenza, matriz_recompensas);

                salir=0; return; % reinicio
                
        end
        
        
        if (suma_total_b<suma_total_j)
        
                disp('');
                disp('Partida ganada');
                
                dinero=dinero+apuesta;
                partidas_ganadas= partidas_ganadas +1;
                
                if (apuesta_doble==1)
                    apuesta_doble=0;
                    recompenza=100;
                else
                    recompenza=50;
                end
                
                
                %q-l
            
                %for p=1:length(recorrido_filas_recompenzas)
                %matriz_recompensas(recorrido_filas_recompenzas(p),recorrido_columnas_recompenzas(p))= matriz_recompensas(recorrido_filas_recompenzas(p),recorrido_columnas_recompenzas(p))-recompenza;
                %end
                
                
                if ( (not(isempty(recorrido_filas_recompenzas))) )
                    for p=1:(length(recorrido_filas_recompenzas)-1)
                       [matriz_recompensas] = qlearning_online(recorrido_columnas_recompenzas(p), matriz_estados, matriz_estados(recorrido_filas_recompenzas(p),:), matriz_estados(recorrido_filas_recompenzas(p+1),:), recompenza, matriz_recompensas);
                    end
                end
                
                estado_siguiente=[1 1 1 1 1 1];

                [matriz_recompensas] = qlearning_online(accion_resultante, matriz_estados, estados_1, estado_siguiente, recompenza, matriz_recompensas);


                
                 salir=0; return; % reinicio
        end
        
        disp('');
        disp('Partida empatada');
        
            
        salir=0; return; % reinicio
        
        
     end
    
     
     
   
     if ( (decision==3) && (length(cartas_j)==2) )
         
        decision=0;
        
        apuesta_doble=1;
        
        apuesta=apuesta*2;
        
        pos_carta_sacada=randperm(length(barajador),1);

        cartas_j(end+1)=barajador(pos_carta_sacada);

        barajador(pos_carta_sacada)=[];
        
        suma_total_j=sum(cartas_j);
        
        % verifico as
        
        pos=find(cartas_j==11);
    
        if ( (not(isempty(pos))) && (suma_total_j>21) ) 

            cartas_j(pos)=1;

            suma_total_j=sum(cartas_j);
	
        end
        
        
        disp('');
        disp('cartas jugador:');
        cartas_j
    
        
        if (suma_total_j>21)
            
            disp('');
            disp('El jugador se paso. Partida perdida');
     
            dinero=dinero-apuesta;
            
            recompenza=-80;
            
            %q-l
            
            %for p=1:length(recorrido_filas_recompenzas)
            %matriz_recompensas(recorrido_filas_recompenzas(p),recorrido_columnas_recompenzas(p))= matriz_recompensas(recorrido_filas_recompenzas(p),recorrido_columnas_recompenzas(p))+recompenza;
            %end
            
            
            if ( (not(isempty(recorrido_filas_recompenzas))) )

                for p=1:(length(recorrido_filas_recompenzas)-1)
                   [matriz_recompensas] = qlearning_online(recorrido_columnas_recompenzas(p), matriz_estados, matriz_estados(recorrido_filas_recompenzas(p),:), matriz_estados(recorrido_filas_recompenzas(p+1),:), recompenza, matriz_recompensas);
                end
                
            end
            
            estado_siguiente=[0 0 0 0 0 0];
            
            [matriz_recompensas] = qlearning_online(accion_resultante, matriz_estados, estados_1, estado_siguiente, recompenza, matriz_recompensas);
     
            
            salir=0; return; % reinicio
        end
        
        
        estado_siguiente=[suma_total_j,cant_cartas_j,separar_disponible,dinero_disponible,as_disponible,cartas_b(1)]; 
        [matriz_recompensas] = qlearning_online(accion_resultante, matriz_estados, estados_1, estado_siguiente, recompenza, matriz_recompensas);
        
        
        %decision=2;  
      
        %salir=2; return;
        
        
        %--------------------REPLICO DECISION 2-----------
        
        
        suma_total_b=sum(cartas_b);
        
        decision=0;
		
		%blackjack
		
		if ( (suma_total_b==21) && (length(cartas_b)==2) ) 
		
			disp('');
			disp('Black Jack banca:');
			cartas_b
			
			dinero=dinero-apuesta;
			disp('');
			disp('Partida Perdida:');
            
            recompenza=-50;
            
            %q-l
            
            %for p=1:length(recorrido_filas_recompenzas)
            %matriz_recompensas(recorrido_filas_recompenzas(p),recorrido_columnas_recompenzas(p))= matriz_recompensas(recorrido_filas_recompenzas(p),recorrido_columnas_recompenzas(p))+recompenza;
            %end
            
            
            if ( (not(isempty(recorrido_filas_recompenzas))) )
                for p=1:(length(recorrido_filas_recompenzas)-1)
                    [matriz_recompensas] = qlearning_online(recorrido_columnas_recompenzas(p), matriz_estados, matriz_estados(recorrido_filas_recompenzas(p),:), matriz_estados(recorrido_filas_recompenzas(p+1),:), recompenza, matriz_recompensas);
                end
            end    
            
            estado_siguiente=[0 0 0 0 0 0];
            
            [matriz_recompensas] = qlearning_online(accion_resultante, matriz_estados, estados_1, estado_siguiente, recompenza, matriz_recompensas);
			
            
            
			salir=0; return; % reinicio
			
        end
        
        
		
		
		% secuencia normal
		
      
        while (suma_total_b<17)
            
                pos_carta_sacada=randperm(length(barajador),1);

                cartas_b(end+1)=barajador(pos_carta_sacada);

                barajador(pos_carta_sacada)=[];
                
                suma_total_b=sum(cartas_b);
                
                
               % verifico as
        
                pos=find(cartas_b==11);

                if ( (not(isempty(pos))) && (suma_total_b>21) ) 

                    cartas_b(pos)=1;

                    suma_total_b=sum(cartas_b);

                end
        end
        
        disp('');
        disp('cartas banca:');
        cartas_b       
        
        if (suma_total_b>21)
                
                disp('');
                disp('La banca se paso. Partida ganada');
                
                dinero=dinero+apuesta;
                partidas_ganadas= partidas_ganadas +1;
               

                if (apuesta_doble==1)
                    apuesta_doble=0;
                    recompenza=100;
                else
                    recompenza=50;
                end
                
                
                %q-l
            
                %for p=1:length(recorrido_filas_recompenzas)
                %matriz_recompensas(recorrido_filas_recompenzas(p),recorrido_columnas_recompenzas(p))= matriz_recompensas(recorrido_filas_recompenzas(p),recorrido_columnas_recompenzas(p))-recompenza;
                %end
                
                
                if ( (not(isempty(recorrido_filas_recompenzas))) )
                    for p=1:(length(recorrido_filas_recompenzas)-1)
                       [matriz_recompensas] = qlearning_online(recorrido_columnas_recompenzas(p), matriz_estados, matriz_estados(recorrido_filas_recompenzas(p),:), matriz_estados(recorrido_filas_recompenzas(p+1),:), recompenza, matriz_recompensas);
                    end
                end
                
                estado_siguiente=[1 1 1 1 1 1];
            
                [matriz_recompensas] = qlearning_online(accion_resultante, matriz_estados, estados_1, estado_siguiente, recompenza, matriz_recompensas);

                
                salir=0; return; % reinicio
            
        end
        
        
        
        
        if (suma_total_b>suma_total_j)
        
                disp('');
                disp('Partida perdida');
                        
                dinero=dinero-apuesta;
                
                if (apuesta_doble==1)
                    apuesta_doble=0;
                    recompenza=-100;
                else
                    recompenza=-50;
                end
                
                
                
                %q-l
            
                %for p=1:length(recorrido_filas_recompenzas)
                %matriz_recompensas(recorrido_filas_recompenzas(p),recorrido_columnas_recompenzas(p))= matriz_recompensas(recorrido_filas_recompenzas(p),recorrido_columnas_recompenzas(p))-recompenza;
                %end
                
                
                if ( (not(isempty(recorrido_filas_recompenzas))) )
                    for p=1:(length(recorrido_filas_recompenzas)-1)
                        [matriz_recompensas] = qlearning_online(recorrido_columnas_recompenzas(p), matriz_estados, matriz_estados(recorrido_filas_recompenzas(p),:), matriz_estados(recorrido_filas_recompenzas(p+1),:), recompenza, matriz_recompensas);            
                    end
                end
                
                estado_siguiente=[0 0 0 0 0 0];

                [matriz_recompensas] = qlearning_online(accion_resultante, matriz_estados, estados_1, estado_siguiente, recompenza, matriz_recompensas);

                salir=0; return; % reinicio
                
        end
        
        
        if (suma_total_b<suma_total_j)
        
                disp('');
                disp('Partida ganada');
                
                dinero=dinero+apuesta;
                partidas_ganadas= partidas_ganadas +1;
                
                if (apuesta_doble==1)
                    apuesta_doble=0;
                    recompenza=100;
                else
                    recompenza=50;
                end
                
                
                %q-l
            
                %for p=1:length(recorrido_filas_recompenzas)
                %matriz_recompensas(recorrido_filas_recompenzas(p),recorrido_columnas_recompenzas(p))= matriz_recompensas(recorrido_filas_recompenzas(p),recorrido_columnas_recompenzas(p))-recompenza;
                %end
                
                if ( (not(isempty(recorrido_filas_recompenzas))) )
                    for p=1:(length(recorrido_filas_recompenzas)-1)
                       [matriz_recompensas] = qlearning_online(recorrido_columnas_recompenzas(p), matriz_estados, matriz_estados(recorrido_filas_recompenzas(p),:), matriz_estados(recorrido_filas_recompenzas(p+1),:), recompenza, matriz_recompensas);
                    end
                end
                
                estado_siguiente=[1 1 1 1 1 1];

                [matriz_recompensas] = qlearning_online(accion_resultante, matriz_estados, estados_1, estado_siguiente, recompenza, matriz_recompensas);


                
                 salir=0; return; % reinicio
        end
        
        disp('');
        disp('Partida empatada');
        
            
        salir=0; return; % reinicio
        
        
        
        
    end
   
     
    
    
    if ( (decision==4) && (cartas_j(1)==cartas_j(2)) && (length(cartas_j)==2) ) 
    
        decision=0;
        cartas_js1=[];
        cartas_js2=[];
        
        cartas_js1(end+1)=cartas_j(1);
        cartas_js2(end+1)=cartas_j(1);
        
        pos_carta_sacada=randperm(length(barajador),1);
        cartas_js1(end+1)=barajador(pos_carta_sacada);
        barajador(pos_carta_sacada)=[];
        
        pos_carta_sacada=randperm(length(barajador),1);
        cartas_js2(end+1)=barajador(pos_carta_sacada);
        barajador(pos_carta_sacada)=[];
        
        suma_total_js1=sum(cartas_js1);
        suma_total_js2=sum(cartas_js2);
        
        
        % verifico as 1
        
        pos=find(cartas_js1==11);
    
        if ( (not(isempty(pos))) && (suma_total_js1>21) ) 

        cartas_js1(pos)=1;
        
        suma_total_js1=sum(cartas_js1);
	
        end
        
        
                
        
        pos=find(cartas_js1==1);
    
        if ( (not(isempty(pos))) )  

        cartas_js1(pos)=11;
        
        suma_total_js1=sum(cartas_js1);
	
        end
        
   
        
        
        % verifico as 2
        
        pos=find(cartas_js2==11);
    
        if ( (not(isempty(pos))) && (suma_total_js2>21) ) 

        cartas_js2(pos)=1;
        
        suma_total_js2=sum(cartas_js2);
	
        end
        
        
        
        pos=find(cartas_js2==1);
    
        if ( (not(isempty(pos))) ) 

        cartas_js2(pos)=11;
        
        suma_total_js2=sum(cartas_js2);
	
        end
        
       
        disp('');
        disp('cartas jugador s1:');
        cartas_js1
        
        
        disp('');
        disp('cartas jugador s2:');
        cartas_js2
        
        
        if (suma_total_js1>21)
           
            disp('');
            disp('se paso primera separacion.');

            dinero=dinero-apuesta;
            
        end
        
        if (suma_total_js2>21)
            
            disp('');
            disp('se paso segunda separacion.');
            dinero=dinero-apuesta;
            
        end
        
        
        if ( (suma_total_js1>21) && (suma_total_js2>21) )
       
             salir=0; return; % reinicio
        end
         
        
        % decision 2 para separar
        
        suma_total_b=sum(cartas_b);
        
        while (suma_total_b<17)
            
                pos_carta_sacada=randperm(length(barajador),1);

                cartas_b(end+1)=barajador(pos_carta_sacada);

                barajador(pos_carta_sacada)=[];
                
                suma_total_b=sum(cartas_b);
                
                % verifico as
        
                pos=find(cartas_b==11);

                if ( (not(isempty(pos))) && (suma_total_b>21) ) 

                    cartas_b(pos)=1;

                    suma_total_b=sum(cartas_b);

                end
        end
        
        disp('');
        disp('cartas banca:');
        cartas_b       
        
        
        if (suma_total_b>21)
                
                disp('');
                disp('La banca se paso. Partida ganada');
                
                partidas_ganadas= partidas_ganadas +1;
                
   
                if ( (suma_total_js1<21) && (suma_total_js2<21) )
       
                            dinero=dinero+(apuesta*2);
                            recompenza=70;
                else
                            dinero=dinero+apuesta;
                            recompenza=30;
                
                end
                
                
                %q-l
            
                %for p=1:length(recorrido_filas_recompenzas)
                %matriz_recompensas(recorrido_filas_recompenzas(p),recorrido_columnas_recompenzas(p))= matriz_recompensas(recorrido_filas_recompenzas(p),recorrido_columnas_recompenzas(p))+recompenza;
                %end
                
                
                if ( (not(isempty(recorrido_filas_recompenzas))) )
                    for p=1:(length(recorrido_filas_recompenzas)-1)
                       [matriz_recompensas] = qlearning_online(recorrido_columnas_recompenzas(p), matriz_estados, matriz_estados(recorrido_filas_recompenzas(p),:), matriz_estados(recorrido_filas_recompenzas(p+1),:), recompenza, matriz_recompensas);
                    end
                end
                
                estado_siguiente=[1 1 1 1 1 1];

                [matriz_recompensas] = qlearning_online(accion_resultante, matriz_estados, estados_1, estado_siguiente, recompenza, matriz_recompensas);

                
                salir=0; return; % reinicio
            
        end
        
        
        
        if ( (suma_total_b>suma_total_js1) && (suma_total_js1<21) )
        
                disp('');
                disp('Perdida en separacion 1');
                        
                dinero=dinero-apuesta;
                recompenza=recompenza-50;
             
        end
        
        
        
        if ( (suma_total_b>suma_total_js2)  && (suma_total_js2<21) ) 
        
                disp('');
                disp('Perdida en separacion 2');
                        
                dinero=dinero-apuesta;
                recompenza=recompenza-50;
                
        end
        
        
        if ( (suma_total_b<suma_total_js1) && (suma_total_js1<21) )
        
                disp('');
                disp('Ganada en separacion 1');
                        
                dinero=dinero+apuesta;
                recompenza=recompenza+50;
                
        end
        
        
        if ( (suma_total_b<suma_total_js2) && (suma_total_js2<21) )
        
                disp('');
                disp('Ganada en separacion 2');
                        
                dinero=dinero+apuesta;
                recompenza=recompenza+50;
        end
        
        
        if ( (suma_total_b==suma_total_js1)  && (suma_total_js1<21) )
        
                disp('');
                disp('Empate en separacion 1');
         
        end
        
        
        if ( (suma_total_b==suma_total_js2) && (suma_total_js1<21) )
        
                disp('');
                disp('Empate en separacion 2');
         
        end
        
        
        if (recompenza>0)
           partidas_ganadas=partidas_ganadas+1; 
        end
        
        
            if (recompenza~=0)

                %q-l

                %for p=1:length(recorrido_filas_recompenzas)
                %matriz_recompensas(recorrido_filas_recompenzas(p),recorrido_columnas_recompenzas(p))= matriz_recompensas(recorrido_filas_recompenzas(p),recorrido_columnas_recompenzas(p))+recompenza;
                %end
                
                
                if ( (not(isempty(recorrido_filas_recompenzas))) )
                    for p=1:(length(recorrido_filas_recompenzas)-1)
                       [matriz_recompensas] = qlearning_online(recorrido_columnas_recompenzas(p), matriz_estados, matriz_estados(recorrido_filas_recompenzas(p),:), matriz_estados(recorrido_filas_recompenzas(p+1),:), recompenza, matriz_recompensas);
                    end
                end
                
                if (recompenza>0)
                    estado_siguiente=[1 1 1 1 1 1];
                else
                    estado_siguiente=[0 0 0 0 0 0];
                end
                
                [matriz_recompensas] = qlearning_online(accion_resultante, matriz_estados, estados_1, estado_siguiente, recompenza, matriz_recompensas);
           
            end
        
        
        
        
        salir=0; return; % reinicio
      
    end
    
    
end
    


