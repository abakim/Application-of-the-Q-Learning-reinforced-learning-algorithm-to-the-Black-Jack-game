function [s] = carga_estados2( )

% s = vector de estados posibles

% Se basan en:

% Suma de las cartas del jugador (elemento 1)

% Cantidad de cartas de Jugador (elemento 2)

% Si puede separar o no (elemento 3)

% Si el dinero que posee es igual o mayor a 200 (elemento 4)

% Si hay o no un as que no se tiene que usar si o si como 1 (elemento 5)

% La carta del coupier que se ve (elemento 6)



s=[]; % inicializo

%------------------------------------------------------------------

for i=2:21
    for j=2:7
        for k=2:11
        
            i_aux=i;
            j_aux=j;

			s(end+1,:) = [i_aux j_aux 0 0 0 k];
            s(end+1,:) = [i_aux j_aux 1 0 0 k];
            
            s(end+1,:) = [i_aux j_aux 0 1 0 k];
            s(end+1,:) = [i_aux j_aux 1 1 0 k];
            
            s(end+1,:) = [i_aux j_aux 0 0 1 k];
            s(end+1,:) = [i_aux j_aux 1 0 1 k];
            
            s(end+1,:) = [i_aux j_aux 0 1 1 k];
            s(end+1,:) = [i_aux j_aux 1 1 1 k];
            
            
            
        end  
    end
end



% filas objetivos (partida ganada y partida perdida) 

%------------------------------------------------------------------




s(end+1,:) = [0 0 0 0 0 0];
s(end+1,:) = [1 1 1 1 1 1];


end


