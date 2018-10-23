% ---------------- Codificador ---------------- %
% Proyecto 1 - Procesamiento Digital de Señales
% Estudiantes:
% - Gabriel Madrigal Boza
% - Marco Oviedo Hernandez
% - Diego Salazar Sibaja

clear;clc;
% ------------ Extraccion de audio ------------ %
% Se obtienen los datos iniciales
[audioArray, Fs, Audio, Canal, fpath_out, metadatos, delta0, delta1, retardo0, retardo1, largoVentana] = data_init();

% ---------------- Enventanado ---------------- %
% Se separa el audio en ventanas
matrizVentanas = windows(audioArray, largoVentana);

% Transforma los metadatos a su representacion ascii binaria
printf("\n----------------------------------------------------------------\n");
printf("***** Inicia proceso de conversion de metadatos *****\n");
printf("----------------------------------------------------------------\n \n");
metadatosBinario = toascii(metadatos);
metadatosBinario = dec2bin(metadatosBinario,8);

% Obtiene el tamaño de la matriz de metadatos
[mFilas, mCols] = size(metadatosBinario);
[vFilas, vCols] = size(matrizVentanas);

% ----------- Multiplexado y kernel ----------- %
printf("\n----------------------------------------------------------------\n");
printf("***** Inicia proceso de codificacion *****\n");
printf("----------------------------------------------------------------\n \n");
vIndx = 1;
largoMax = max(retardo0, retardo1);
matrizResultados = zeros(vFilas, largoMax + largoVentana - 1);

for i = 1:mFilas
  for j = 1:mCols
    % - codigo - %
    if (vIndx <= vFilas)
      matrizResultados(vIndx,:) = Kernel(matrizVentanas(vIndx,:), str2num(metadatosBinario(i,j)), delta0, delta1, retardo0, retardo1);
      %prueba = str2num(metadatosBinario(i,j));
      %disp(prueba);
      ++vIndx;
    endif
  endfor
endfor

if (vIndx <= vFilas)
  for k = vIndx:vFilas
    matrizResultados(k,1:vCols) = matrizVentanas(k,:);
  endfor
endif

printf("\n----------------------------------------------------------------\n");
printf("***** Inicia proceso de combinacion *****\n");
printf("----------------------------------------------------------------\n \n");
% ---------------- Combinacion ---------------- %
audioOutput = combinacion(matrizResultados, vCols);
max_channel = length(audioOutput);
min_channel = length(Audio(:,1));
if(Canal == 1)
 Audio(min_channel+1:max_channel,2) = 0;
 audioFinal = [rot90(audioOutput,-1), Audio(:,2)];
endif
if(Canal == 2)
 Audio(min_channel+1:max_channel,1) = 0;
 audioFinal = [Audio(:,1),rot90(audioOutput,-1)];
endif
% ------------ Escritura de Audio ------------- %
saveaudio(audioFinal, Fs , fpath_out);

printf("\n----------------------------------------------------------------\n");
printf("***** FINALIZO CODIFICACION DE AUDIO *****\n");
printf("----------------------------------------------------------------\n \n");

% ---------- Escritura de Parametros ---------- %
%save params.txt largoVentana retardo0 retardo1 mFilas mCols
