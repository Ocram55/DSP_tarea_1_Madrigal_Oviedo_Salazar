%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Iniciando Datos
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [audioarray,fs,metadatos,delta0,delta1,retardo0,retardo1,win_len]=data_init()
  printf("\n----------------------------------------------------------------\n");
  printf("Seleccione un archivo de audio forma *.wav\n");
  printf("----------------------------------------------------------------\n \n");
  [fname,fpath]=uigetfile({"*.wav"},"AudioLoad");
  printf(fpath);
  audiofile = [fpath fname];
  [audioarray,fs] = audioread(audiofile);
  %%Solicitud de archivo con metadatos
  printf("\n----------------------------------------------------------------\n");
  printf("Introduzca metadatos de la cancion.\n Si desea dejar algun espacio sin llenar solo presione ENTER.\n");
  printf("----------------------------------------------------------------\n \n");
  title = input("Escriba el nombre de la cancion:",'s');
  singer = input("Escriba el nombre del artista principal de la cancion: ",'s');
  autor = input("Escriba el nombre del autor de la cancion: ",'s');
  album = input("Escriba el nombre del album al que pertenece la cancion: ",'s');
  year = input("Escriba el año de publicación de la cancion: ",'s');
  guestsinger = input("Escriba el nombre de los artistas invitados de la cancion: ",'s');
  productor = input("Escriba el nombre del productor de la cancion: ",'s');
  if(length(title) == 0) title = ["!"]; endif
  if(length(singer) == 0) singer = ["!"]; endif
  if(length(autor) == 0) autor = ["!"]; endif
  if(length(album) == 0) album = ["!"]; endif
  if(length(year) == 0) year = ["!"]; endif
  if(length(guestsinger) == 0) guestsinger = ["!"]; endif
  if(length(productor) == 0) productor = ["!"]; endif
  metadatos=[title "*" singer "*" autor "*" album "*" year "*" guestsinger "*" productor];
  %%Solicitud de parametros para codificacion
  printf("\n----------------------------------------------------------------\n");
  printf("Introduzca parametros para codificacion de los metadatos en el audio. \n Si desea dejar algun espacio sin llenar solo presione ENTER.\n");
  printf("----------------------------------------------------------------\n \n");
  delta0 = input("Determine el valor de la amplitud del eco para los bit 0: ");
  retardo0 = ceil((input("Determine el retardo en mili segundos para el valor de bit 0: ")*1e-3)*fs);
  delta1 = input("Determine el valor de la amplitud del eco para los bit 1: ");
  retardo1 = ceil((input("Determine el retardo en mili segundos para el valor de bit 1: ")*1e-3)*fs);
  win_optv = win_opt(audioarray,metadatos,fs);
  printf("*******************************************************************\n");
  printf("El valor recomendado maximo de tiempo por ventana es %f ms.\n",win_optv*1e3);
  printf("*******************************************************************\n");
  win_len = ceil((input("Determine el tiempo por la ventana en mili segundos: ")*1e-3)*fs);
  if(win_len/fs > win_optv)
    error("El tiempo asignado por ventana no permite almacenar todos los metadatos");
  endif
  if(length(delta0) == 0) delta0 =1 ; endif
  if(length(delta1) == 0) delta1 = 1; endif
  if(length(retardo0) == 0) retardo0 =1 ; endif
  if(length(retardo1) == 0) retardo1 = 1; endif
  if(length(win_len) == 0) win_len =1 ; endif
endfunction

function win_optv = win_opt(audioarray,metadatos,fs)
  len_metadatos = length(metadatos);
  len_audioarray = length(audioarray);
  win_optv = ((len_audioarray*(1/fs))/(len_metadatos*8));
endfunction