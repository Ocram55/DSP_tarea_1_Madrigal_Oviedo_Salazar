function rcc = cepstro(vectorIn)
  rcc = abs(ifft(log(abs(fft(vectorIn)))));
endfunction