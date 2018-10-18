% ---------------- Codificador ---------------- %
% Proyecto 1 - Procesamiento Digital de Señales
% Estudiantes:
% - Gabriel Madrigal Boza
% - Marco Oviedo Hernandez
% - Diego Salazar Sibaja

% ------------ Extraccion de audio ------------ %
% Se obtienen los datos iniciales
[audioArray, Fs, metadatos, delta0, delta1, retardo0, retardo1, largoVentana] = data_init();

% ---------------- Enventanado ---------------- %
% Se separa el audio en ventanas
matrizVentanas = windows(audioArray, largoVentana);

% Transforma los metadatos a su representacion ascii binaria
metadatosBinario = toascii(metadatos);
metadatosBinario = dec2bin(metadatosBinario);

% Obtiene el tamaño de la matriz de metadatos
[mFilas, mCols] = size(metadatosBinario);
[vFilas, vCols] = size(matrizVentanas);

vIndx = 1;
matrizResultados = [];

% ----------- Multiplexado y kernel ----------- %
for i = 1:mFilas
  for j = 1:mCols
    % - codigo - %
    if (vIndx <= vFilas)
      matrizResultados(vIndx,:) = Kernel(matrizVentanas(vIndx,:), metadatosBinario(i,j), delta0, delta1, retardo0, retardo1);
      ++vIndx;
    endif
  endfor
endfor

% ---------------- Combinacion ---------------- %
audioOutput = combinacion(matrizResultados, vCols);

% ------------ Escritura de Audio ------------- %
saveaudio(audioOutput, Fs);

