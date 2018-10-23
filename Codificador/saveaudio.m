%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Salvando audio
% Las variables de entrada son el Array con los datos de audio 
% y la frecuencia de muestreo original de la cancion
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function saveaudio(audioarray,fs,fpath)
  file=[fpath "out.wav"];
  audiowrite(file,audioarray,fs);
endfunction