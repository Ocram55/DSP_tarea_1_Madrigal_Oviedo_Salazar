%combinacion

% yn= vectores de muestra quew vienen de la respuesta al impulso
% L= largo del que deberia ser la muestra original
   function combinacion (yn,L)
   M= length yn;  % M= largo de la muestra x(n)
   y = zeros(1, L+M-1); % mi salida total
  
  for i = 1: L :M ;  %(M: ultimo objeto dentro de x[n])     
        tail= y(L+1:L+M-1);
        if (i==1)
            y(1:L-1) = y(1:L-1);   
        else
            y(1:L-1) = y(1:L-1) + tail; %(add the overlapped output blocks)
   end
  