%combinacion

% matrizIn = matriz con los vectores de salida de los kernel
% L = largo de la muestra original

function y = combinacion (matrizIn,L)
  [mFilas, mCols] = size(matrizIn);
  y = zeros(1, mFilas*mCols);
  
  y(1,1:mCols) = matrizIn(1,:);
  for i = 1:(mFilas-1)
    y(1,(i*L)+1) = matrizIn(i+1,:);
  endfor
endfunction
  