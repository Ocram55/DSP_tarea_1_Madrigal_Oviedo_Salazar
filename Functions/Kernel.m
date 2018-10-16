function out = Kernel(inVec, bit)
  amp_0 = 0.75;
  delay_0 = 10;
  kernel_0 = zeros(1,delay_0);
  kernel_0(1,1) = 1;
  kernel_0(1,end) = amp_0;

  amp_1 = 0.5;
  delay_1 = 15;
  kernel_1 = zeros(1,delay_1);
  kernel_1(1,1) = 1;
  kernel_1(1,end) = amp_1;

  out = [];
  if (bit == 0)
    out = conv(inVec, kernel_0);
  elseif (bit == 1)
    out = conv(inVec, kernel_1);
  else
    error ("Valor de bit invalido!");
  endif
endfunction
