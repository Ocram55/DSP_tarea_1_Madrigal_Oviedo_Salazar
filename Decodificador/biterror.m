findstr (metadatosDeco, "@")
metadatos_recuperados = metadatosDeco(1:22);
metadatos_original = load("../params.txt").("metadatos");
metadatos_B_o =  toascii(metadatos_original);
metadatos_B_o =  dec2bin(metadatos_B_o,8);
metadatos_B_r = toascii(metadatos_recuperados);
metadatos_B_r =  dec2bin(metadatos_B_r,8);
min_v = min(length(metadatos_B_r),length(metadatos_B_o));
cont = 0;
for i = 1:min_v
    for j = 1:8
      if(metadatos_B_r(i,j) != metadatos_B_o(i,j))
        ++cont;
      endif
    endfor
  endfor
printf("El porcentaje de error es %f\n",(cont/(min_v*8))*100);