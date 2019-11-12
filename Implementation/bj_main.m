function [matriz_recompensas,partidas_ganadas,partida, dinero_partidas] = bj_main(matriz_recompensas,epsilon)

%partida, partidas_ganadas, dinero_partidas, matriz_recompensas
% epsilon = mientras más cercano a 1 más al azar es. Si es 1 es al azar total
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

dinero_disponible=1;
separar_disponible=0;
cant_cartas_j=0;
as_disponible=0;
matriz_estados=[];
dinero_partidas=[];
recorrido_filas_recompenzas=[];
recorrido_columnas_recompenzas=[];
cartas_j=[];
cartas_b=[];
apuesta=0;
apuesta_doble=0;
decision=0;
estado_q=0;
estado_siguiente=0;
accion_resultante=0;
estados_1=[];
suma_total_j=0;

% blackjack

blackjack=0;
contadores_blackjack=0;

% demora

%delay=1;

fin_juego=0;


% matriz_estados=carga_estados();

matriz_estados=carga_estados2();  % cargo estados posibles
salir=0;

%---------------------------------------------------------------------%

  % bucle principal
  
  while (salir~=5)
      
      if (salir==0)
          [salir,mazo,dinero,barajador,recorrido_filas_recompenzas, recorrido_columnas_recompenzas, cartas_j, cartas_b,apuesta,apuesta_doble,decision,estado_q,estado_siguiente,accion_resultante,estados_1,fin_juego,suma_total_j,blackjack,cant_cartas_j,dinero_disponible,separar_disponible,as_disponible,partida, partidas_ganadas, recompenza, cuenta_mezcla,matriz_estados, dinero_partidas, contadores_blackjack, epsilon, matriz_recompensas  ] = comienzo_partida(salir,mazo,dinero,barajador,recorrido_filas_recompenzas, recorrido_columnas_recompenzas, cartas_j, cartas_b,apuesta,apuesta_doble,decision,estado_q,estado_siguiente,accion_resultante,estados_1,fin_juego,suma_total_j,blackjack,cant_cartas_j,dinero_disponible,separar_disponible,as_disponible,partida, partidas_ganadas, recompenza, cuenta_mezcla,matriz_estados, dinero_partidas, contadores_blackjack, epsilon, matriz_recompensas);
      end
      
      if (salir==2)
        [salir,mazo,dinero,barajador,recorrido_filas_recompenzas, recorrido_columnas_recompenzas, cartas_j, cartas_b,apuesta,apuesta_doble,decision,estado_q,estado_siguiente,accion_resultante,estados_1,fin_juego,suma_total_j,blackjack,cant_cartas_j,dinero_disponible,separar_disponible,as_disponible,partida, partidas_ganadas, recompenza, cuenta_mezcla,matriz_estados, dinero_partidas, contadores_blackjack, epsilon, matriz_recompensas  ] = toma_decisiones(salir,mazo,dinero,barajador,recorrido_filas_recompenzas, recorrido_columnas_recompenzas, cartas_j, cartas_b,apuesta,apuesta_doble,decision,estado_q,estado_siguiente,accion_resultante,estados_1,fin_juego,suma_total_j,blackjack,cant_cartas_j,dinero_disponible,separar_disponible,as_disponible,partida, partidas_ganadas, recompenza, cuenta_mezcla,matriz_estados, dinero_partidas, contadores_blackjack, epsilon, matriz_recompensas);    
      end
      
  end
  
end


