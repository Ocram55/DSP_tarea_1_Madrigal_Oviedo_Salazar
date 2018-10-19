function out = Kernel(inVec, bit, amp_0, amp_1, delay_0, delay_1)
  largoMax = max(delay_0, delay_1);
  
  kernel_0 = zeros(1,largoMax);
  kernel_0(1,1) = 1;
  kernel_0(1,delay_0) = amp_0;

  kernel_1 = zeros(1,largoMax);
  kernel_1(1,1) = 1;
  kernel_1(1,delay_1) = amp_1;

  out = [];
  if (bit == 0)
    out = conv(inVec, kernel_0);
  elseif (bit == 1)
    out = conv(inVec, kernel_1);
  else
    error ("Valor de bit invalido!");
  endif
endfunction
