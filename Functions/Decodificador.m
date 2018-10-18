% ---------------- Decodificador ---------------- %
% Proyecto 1 - Procesamiento Digital de Señales
% Estudiantes:
% - Gabriel Madrigal Boza
% - Marco Oviedo Hernandez
% - Diego Salazar Sibaja

% --------------- Leer Parametros --------------- %
largoVentana = load("params.txt").("largoVentana");

% ----------------- Leer Audio ------------------ %
printf("\n----------------------------------------------------------------\n");
printf("Seleccione un archivo de audio forma *.wav\n");
printf("----------------------------------------------------------------\n \n");
[fname, fpath]=uigetfile({"*.wav"},"AudioLoad");
audiofile = [fpath fname];
[audioArray, Fs] = audioread(audiofile);

% ----------------- Enventenado ----------------- %
% Se separa el audio en ventanas
matrizVentanas = windows(audioArray, largoVentana);
[vFilas, vCols] = size(matrizVentanas);

% --------------- Autocorrelacion --------------- %
matrizRCC = zeros(vFilas, vCols);

for i = 1:vFilas
  matrizRCC(i,:) = cepstro(matrizVentanas(i,:));
endfor



