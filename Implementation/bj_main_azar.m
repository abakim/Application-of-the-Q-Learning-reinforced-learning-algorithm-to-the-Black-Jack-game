function [partidas_ganadas,partida,dinero_partidas] = bj_main_azar()


% Definicion de valores de cartas


C_2=2;
C_3=3;
C_4=4;
C_5=5;
C_6=6;
C_7=7;
C_8=8;
C_9=9;
C_10=10;
C_J=10;
C_Q=10;
C_K=10;
C_A=11;


% creo mazo con cartas definidas tradicionalmente (4 de cada tipo)

mazo=[C_2, C_2, C_2, C_2,  C_3, C_3, C_3, C_3, ...  
      C_4, C_4, C_4, C_4,  C_5, C_5, C_5, C_5, ...
      C_6, C_6, C_6, C_6,  C_7, C_7, C_7, C_7, ...
      C_8, C_8, C_8, C_8,  C_9, C_9, C_9, C_9, ...
      C_10, C_10, C_10, C_10,  C_J, C_J, C_J, C_J, ...
      C_Q, C_Q, C_Q, C_Q,      C_K,  C_K,  C_K,  C_K,  ... 
      C_A, C_A, C_A, C_A];

  
% pongo 4 mazos en el barajador 

barajador=[mazo mazo mazo mazo];


% contadores

partida=0;
partidas_ganadas=0;
recompenza=0;

cuenta_mezcla=0;

% dinero inicial
 dinero=1000;

dinero_partidas=[];


% blackjack

blackjack=0;
contadores_blackjack=0;

% demora

%delay=1;

fin_juego=0;

matriz_mc_aux=[];
matriz_mc=[];


comienzo_partida;

%---------------------------------------------------------------------%

  % bucle principal
  
  function comienzo_partida
      
 
    if (dinero<100)
    
    disp('Fin de juego. No tiene mas dinero');
    
    disp('Partidas totales jugadas: ');
    partida
   
    disp('Dinero conseguido en cada partida: ');
    dinero_partidas
    
    decision=0;
    
    fin_juego=1;

    return;
    
    end
    
    
    
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

    matriz_mc_aux=[];
    
    partida=partida+1; % incremento partida
    
    disp('Comienzo de partida: ');
    partida
    
    
    cuenta_mezcla=cuenta_mezcla+1;
      
    cartas_j=[];
    
    cartas_b=[];
    
    apuesta=100; % apuesta inicial
    
    apuesta_doble=0;
    
    decision=0;
    

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
       
    end

	
	
	% comportamiento As
	
    pos=find(cartas_j==11);
    
	if ( (not(isempty(pos))) && (suma_total_j>21) ) 

        cartas_j(pos)=1;
        
        pos=find(cartas_j==11);
        
        % Verifico si hay otro as
    
        if ( (not(isempty(pos))) && (length(cartas_j)==2) )  

                cartas_j(pos)=1;

        end
        
        suma_total_j=sum(cartas_j);
	
    end
    
        toma_decisiones;
  
    
    % decisiones
    
    function toma_decisiones

    if (fin_juego==1)
        return;
    end
    
    disp('');    
    disp('-------------------------------d--------------------------------------');  
        
    disp('');
    disp('cartas jugador:');
    cartas_j
    
    disp('');
    disp('carta banca:');
    cartas_b(1)
    
    
    if (decision==0)
      
    
    
        % Toma de decisiones (1 - pedir, 2 - plantar, 3 - doblar, 4 - dividir)
        
        % DECISION 5 COMPORTAMIENTO AS?

        disp('');
%         decision=input('Decision a tomar: ')
        decision = randperm(4,1);

		
		
		
		%----------------------------------------------------------------------
		
		% Q-learning
		
        %{

        % cargo estados

        estados1=[carta_j,cartas_b(!),suma_total_j,dinero,apuesta,partida];


        % llamo a decision_agente

       [accion,yval]=decision_agente(estados1,A,neu,T);

        %}


		
		%----------------------------------------------------------------------
		
		
		
		
		
		
        % validaciones
        
       
        
        if ( (decision==3) && (dinero<200) ) 
            
            decision=0;
            disp('');
            disp('No es posible doblar con la cantidad de dinero disponible');
            toma_decisiones;
            
        end
        
        
        if ( (decision==4) && (dinero<200) ) 
            
            decision=0;
            disp('');
            disp('No es posible separar con la cantidad de dinero disponible');
            toma_decisiones;

        end
        
        
        if ( (decision==3) && (length(cartas_j)>2) ) 

            decision=0;
            disp('');
            disp('No se puede doblar ya que tiene mas de dos cartas');
            toma_decisiones;

        end


        if ( (decision==4) && ( (cartas_j(1)~=cartas_j(2)) ) ) 
            
            decision=0;
            disp('');
            disp('No se pueden separar cartas debido a que son distintas');
            toma_decisiones;

        end


        if ( (decision==4) && (length(cartas_j)~=2) ) 

            decision=0;
            disp('');
            disp('No se pueden separar cartas debido a que tiene mas de dos cartas');
            toma_decisiones;
        end
        
        
        if ( (decision<1) || (decision>4) )
            
              decision=0;
              
              disp('');
              disp('Decision no respondiente. Reintente');
              toma_decisiones;
        end
        
        if (not(isnumeric(decision)))
        
        d_aux=str2num(decision);
        
            if (isempty(d_aux))
            
                 decision=0;

                  disp('');
                  disp('Decision no respondiente. Reintente');
                  toma_decisiones;
            end    
        end
        
        l=10-length(cartas_j);
        
        matriz_mc_aux(end+1,:)=[cartas_j,zeros(l,1)',cartas_b(1),decision];
        
        
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
        
        
           
        % matriz
        
        pos_m=find(matriz_mc_aux(end,:)==0);
        pos_m=pos_m(1);
        
        matriz_mc_aux(end,pos_m)=cartas_j(end);
        
        
        
        
        disp('');
        disp('cartas jugador:');
        cartas_j
    
        
        if (suma_total_j>21)
           
            dinero=dinero-apuesta;
            
            disp('');
            disp('El jugador se paso. Partida perdida');
            recompenza=recompenza-50;
     
            comienzo_partida; % reinicio    
        end
        
        toma_decisiones;
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
					comienzo_partida; % reinicio
			
                end
				
			dinero=dinero-apuesta;
			disp('');
			disp('Partida Perdida:');
            
            recompenza=recompenza-50;
			
			comienzo_partida; % reinicio
			
        end
        
        
		
		if (blackjack==1)
            
        % Partida ganada
		
        
		blackjack=0;
		dinero= dinero + (apuesta * 1.5); 
        partidas_ganadas=partidas_ganadas+1;
        recompenza=recompenza+70;
        l=10-length(cartas_j);
        matriz_mc_aux(end+1,:)=[cartas_j,zeros(l,1)',cartas_b(1),2];
        matriz_mc=[matriz_mc;matriz_mc_aux];
        comienzo_partida; % reinicio
		
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
                
                matriz_mc=[matriz_mc;matriz_mc_aux];

                if (apuesta_doble==1)
                    apuesta_doble=0;
                    recompenza=recompenza+100;
                else
                    recompenza=recompenza+50;
                end
                
                comienzo_partida; % reinicio
            
        end
        
        if (suma_total_b>suma_total_j)
        
                disp('');
                disp('Partida perdida');
                        
                dinero=dinero-apuesta;
                
                if (apuesta_doble==1)
                    apuesta_doble=0;
                    recompenza=recompenza-100;
                else
                    recompenza=recompenza-50;
                end
                
                comienzo_partida; % reinicio
                
        end
        
        if (suma_total_b<suma_total_j)
        
                disp('');
                disp('Partida ganada');
                
                matriz_mc=[matriz_mc;matriz_mc_aux];
                        
                dinero=dinero+apuesta;
                partidas_ganadas= partidas_ganadas +1;
                
                if (apuesta_doble==1)
                    apuesta_doble=0;
                    recompenza=recompenza+100;
                else
                    recompenza=recompenza+50;
                end
                
                comienzo_partida; % reinicio
        end
        
        disp('');
        disp('Partida empatada');
        
            
        comienzo_partida; % reinicio
        
        
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
        
        
        % matriz
        pos_m=find(matriz_mc_aux(end,:)==0);
        pos_m=pos_m(1);
        
        matriz_mc_aux(end,pos_m)=cartas_j(end);
        
        
        disp('');
        disp('cartas jugador:');
        cartas_j
    
        
        if (suma_total_j>21)
            
            disp('');
            disp('El jugador se paso. Partida perdida');
     
            dinero=dinero-apuesta;
            
            recompenza=recompenza-80;
            
            comienzo_partida; % reinicio
        end
        
        decision=2;  
      
        toma_decisiones;
        
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
        
        
                   
        % matriz
        
        pos_m=find(matriz_mc_aux(end,:)==0);
        pos_m=pos_m(1);
        
        matriz_mc_aux(end,pos_m)=cartas_js1(end);
        
        
        
        % verifico as 2
        
        pos=find(cartas_js2==11);
    
        if ( (not(isempty(pos))) && (suma_total_js2>21) ) 

        cartas_js2(pos)=1;
        
        suma_total_js2=sum(cartas_js2);
	
        end
        
        
       
        % matriz
        
        pos_m=find(matriz_mc_aux(end,:)==0);
        pos_m=pos_m(1);
        
        matriz_mc_aux(end,pos_m)=cartas_js2(end);
        

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
       
             comienzo_partida; % reinicio
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
                
                matriz_mc=[matriz_mc;matriz_mc_aux];

                
                if ( (suma_total_js1<21) && (suma_total_js2<21) )
       
                            dinero=dinero+(apuesta*2);
                            recompenza=recompenza+70;
                else
                            dinero=dinero+apuesta;
                            recompenza=recompenza+30;
                
                end
                
                comienzo_partida; % reinicio
            
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
                partidas_ganadas= partidas_ganadas +1;
                matriz_mc=[matriz_mc;matriz_mc_aux];
                recompenza=recompenza+50;
        end
        
        
        if ( (suma_total_b<suma_total_js2) && (suma_total_js2<21) )
        
                disp('');
                disp('Ganada en separacion 2');
                        
                dinero=dinero+apuesta;
                partidas_ganadas= partidas_ganadas +1;
                matriz_mc=[matriz_mc;matriz_mc_aux];
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
        
        comienzo_partida; % reinicio
      
    end
    
    
   end
    
    %pause(delay); 
    
    
  end


end


