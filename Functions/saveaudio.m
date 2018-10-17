%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Salvando audio
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function saveaudio(audioarray,fs)
  printf("Seleccione la carpeta donde desea guardar su archivo *.wav codificado \n");
  fpath=uigetdir("Salvar Audio");
  file=[fpath "/audio_output.wav"];
  audiowrite(file,audioarray,fs);
endfunction
