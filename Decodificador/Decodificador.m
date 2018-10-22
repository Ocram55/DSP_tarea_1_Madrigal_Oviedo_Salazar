% ---------------- Decodificador ---------------- %
% Proyecto 1 - Procesamiento Digital de Señales
% Estudiantes:
% - Gabriel Madrigal Boza
% - Marco Oviedo Hernandez
% - Diego Salazar Sibaja

% --------------- Leer Parametros --------------- %
largoVentana = load("params.txt").("largoVentana");
delayA = load("params.txt").("retardo0");
delayB = load("params.txt").("retardo1");
mFilas = load("params.txt").("mFilas");
mCols  = load("params.txt").("mCols");

% ----------------- Leer Audio ------------------ %
printf("\n----------------------------------------------------------------\n");
printf("Seleccione un archivo de audio forma *.wav\n");
printf("----------------------------------------------------------------\n \n");
%%[fname,fpath]=uigetfile({"*.wav"},"AudioLoad");
%%printf(fpath);
%%audiofile = [fpath fname];
audiofile = input("Escriba el path de la cancion codificada de la forma /it/is/the/file.wav : ",'s');
[audioArray, Fs] = audioread(audiofile);

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

% *********** Clasificador e Interprete *********** %
printf("\n----------------------------------------------------------------\n");
printf("Inicia proceso de clasificación e interpretación de datos.\n");
printf("----------------------------------------------------------------\n \n");
% ---------------- Clasificador ----------------- %
clasificadorOut = zeros(1, vFilas);
for j = 1:vFilas
  clasificadorOut(1, j) = Clasificador(matrizRCC(j, :), delayA, delayB);
endfor

% ----------------- Interprete ------------------ %
charIndx = floor(vFilas/mCols);
metadatosDeco = "";

for k = 1:charIndx
  metadatosDeco = strcat(metadatosDeco, Interprete(clasificadorOut(1,(k-1)*mCols+1:(k-1)*mCols+mCols)));
endfor

printf(metadatosDeco);