%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Salvando audio
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function saveaudio(audioarray,fs)
  gtk_window_set_transient_for();
  printf("Seleccione un archivo de audio forma *.wav\n");
  fpath=uigetdir("Salvar Audio");
  printf(fpath)

  %audiowrite(audioarray,fs);
  
endfunction
