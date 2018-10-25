% ---------------- Decodificador ---------------- %
% Proyecto 1 - Procesamiento Digital de Señales
% Estudiantes:
% - Gabriel Madrigal Boza
% - Marco Oviedo Hernandez
% - Diego Salazar Sibaja

% --------------- Leer Parametros --------------- %
clear;clc;
[audioArray, fs, delayA, delayB, largoVentana]=deco_init();
mCols = 8;

% ----------------- Enventenado ----------------- %
% Se separa el audio en ventanas
matrizVentanas = windows(audioArray, largoVentana);
[vFilas, vCols] = size(matrizVentanas);

% --------------- Autocorrelacion --------------- %
printf("\n----------------------------------------------------------------\n");
printf("Inicia proceso de obtener la autocorrelacion de cepstro.\n");
printf("----------------------------------------------------------------\n \n");
matrizRCC = zeros(vFilas, vCols);
for i = 1:vFilas
  matrizRCC(i,:) = cepstro(matrizVentanas(i,:));
endfor

%%Reconocedor de ventanas vacias

% *********** Clasificador e Interprete *********** %
printf("\n----------------------------------------------------------------\n");
printf("Inicia proceso de clasificación e interpretación de datos.\n");
printf("----------------------------------------------------------------\n \n");
% ---------------- Clasificador ----------------- %
clasificadorOut = zeros(1, vFilas);
for j = 1:vFilas
  %temp = Clasificador(matrizRCC(j, :), delta0, delta1, delayA, delayB);
  %if(temp < 2)
  %  clasificadorOut(1, j) = temp;
  %endif
  clasificadorOut(1, j) = Clasificador(matrizRCC(j, :), delayA, delayB);
endfor

% ----------------- Interprete ------------------ %
charIndx = floor(vFilas/mCols);
metadatosDeco = "";

for k = 1:charIndx
  metadatosDeco = strcat(metadatosDeco, Interprete(clasificadorOut(1,(k-1)*mCols+1:(k-1)*mCols+mCols)));
endfor

printf("\n----------------------------------------------------------------\n");
printf("Metadatos recuperados\n");
printf("----------------------------------------------------------------\n \n");
metadatos_recuperados = print_metadatos(metadatosDeco);

printf("\n----------------------------------------------------------------\n");
printf("***** FIN DE DECODIFICACION *****\n");
printf("----------------------------------------------------------------\n \n");

error_cal = input("Si quiere obtener el procentaje de error respecto a los metadatos originales presione alguna letra, de lo contrario precione ENTER : ",'s');
if(length(error_cal) == 0)
  printf("Fin de programa\n");
else
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
endif