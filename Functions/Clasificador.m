function bitOut = Clasificador(inCepstro, dA, dB)
  # Los retrasos dA (para el 0) y dB (para el 1)
  # estan dados en muestras. dB siempre es mayor
  # a dA.
  
  # +/- 3 muestras alrededor de dA
  nearA = inCepstro(1,dA-3:dA+3);
  # +/- 3 muestras alrededor de dB
  nearB = inCepstro(1,dB-3:dB+3);
  
  peakA = max(nearA);
  peakB = max(nearB);
  
  if (peakA > peakB)
    bitOut = 0;
  elseif (peakA < peakB)
    bitOut = 1;
  else 
    bitOut = 1;
  endif
endfunction