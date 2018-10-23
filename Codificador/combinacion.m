%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Convolucion de los bits
% Esta función se encarga de realizar la convolución respectiva de las ventanas 
% con el sistema correspondiente si el bit es 1 o 0
% Las variables de entrada son:
% - matrizIn = matriz con los vectores de salida de los kernel
% - L = largo de la muestra original
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function y = combinacion (matrizIn,L)
  [mFilas, mCols] = size(matrizIn);
  %disp(mFilas);
  %disp(mCols);
  %disp(L);
  y = zeros(1, mFilas*mCols);
  
  y(1,1:mCols) = matrizIn(1,1:mCols);
  for i = 1:(mFilas-1)
    y(1,(i*L)+1:(i*L)+mCols) = matrizIn(i+1,:) + y(1,(i*L)+1:(i*L)+mCols);
  endfor
  
endfunction