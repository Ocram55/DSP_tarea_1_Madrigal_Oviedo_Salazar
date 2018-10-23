% ---------------- Decodificador ---------------- %
% Proyecto 1 - Procesamiento Digital de Señales
% Estudiantes:
% - Gabriel Madrigal Boza
% - Marco Oviedo Hernandez
% - Diego Salazar Sibaja

% --------------- Leer Parametros --------------- %
clear;clc;
[audioArray, fs, delta0, delta1, delayA, delayB, largoVentana]=deco_init();
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

%printf(metadatosDeco);