function [Qtable] = qlearning_online(accion, index_e, estado, siguienteEstado, recompenza, Qtable)
%   accion = decision tomada
%   index_e = matriz de estados correspondiente a las filas de Qtable.
%   estado = estado actual

%   // Para probar \\
%   Qtable=zeros(11,4);
%   index_e=[5 10 2 0 0 0 0 0 0 0 8 2; 10 10 0 0 0 0 0 0 0 0 10 2; 1 3 7 9 0 0 0 0 0 0 8 4]
%   estado_a = [10 10 0 0 0 0 0 0 0 0 10 2]
%   siguienteEstado_a = [1 3 7 9 0 0 0 0 0 0 8 4]
%   Qtable(10,3) = 200      % Se hace que la acción 3 tenga mayor recompenza
%   [acc_r, Qtable]=qlearning_online(2, index_e, estado_a, siguienteEstado_a, 100, Qtable)
     
    alfa = 0.05;    % learning rate
    % 0 significa que no aprendemos nada de una
    % nueva experiencia, y 1 significa que olvidamos 
    % todo lo que sabíamos hasta ahora y nos fiamos 
    % completamente de la nueva experiencia.

    gamma = 0.7;    % discount rate
    % ayuda a mezclar recompensas directas con recompensas a largo plazo y producir la recompensa mixta.
    % 0 = solo importan las recompensas inmediatas (se dan al principio)
    % 1 = solo importan las recompensas a largo plazo
    % 1 tiende a divergir (nunca encontrar una solución). Si no se incluye
    % este factor no sabe como encontrar un camino para una solución.
    
    siguienteEstado_q = 1;
    estado_q = 1;
    
    
    % Se busca a que fila de Qtable corresponde el estado_a
    
       for i=1:size(index_e,1) % recorro por fila
%            index_e(i,:)
            if (index_e(i,:) == estado)
                estado_q=i;
            end
       end
    
    % Se busca a que fila de Qtable corresponde el siguienteEstado_a
    for i=1:size(index_e,1) % recorro por fila
        if (index_e(i,:) == siguienteEstado)
            siguienteEstado_q=i;
        end
    end
    
    % FORMULA Q-LEARNING
    % Q(s,a) = Q(s,a) + alfa*[R(s,a) + gamma*(maxQ(s',a') - Q(s,a)]
    
    % // Actualizacion de recompensa mixta (celda de la tabla) \\
    % teniendo una experiencia (estado, acción, refuerzo, siguienteEstado)
    % maxQ(s',:)
    % s' = siguienteEstado
    % Incentiva a que la siguiente acción del estado, sea la de mayor recompensa 
    siguienteRefuerzoMixto = max(Qtable(siguienteEstado_q,:)); 
    
    
    % Se aplica la formula (se carga Qtable)
    Qtable(estado_q,accion) =  Qtable(estado_q,accion) + alfa*(recompenza + gamma*siguienteRefuerzoMixto - Qtable(estado_q,accion));

    
end