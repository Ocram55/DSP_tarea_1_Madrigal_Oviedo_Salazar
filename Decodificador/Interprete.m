function asciiOut = Interprete(arrayIn)
  auxA = num2str(arrayIn);
  auxA = bin2dec(auxA);
  asciiOut = char(auxA);
endfunction