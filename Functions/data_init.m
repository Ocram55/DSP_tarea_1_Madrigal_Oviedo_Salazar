%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Devuelve una variable tipo array NxM donde:
%%  -N = Cantidad de ventanas creadas
%%  -M = Cantidad de elementos por ventana
%% La función tiene como parametros:
%%  - audioarray = Array con elementos de audioarray
%%  - win_len = Cantidad de elementos por ventana [audioarray,fs,title,singer,autor,album,year,guestsinger,productor,delta,retardo0,retardo1,win_len]=
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [audioarray,fs,metadatos,delta,retardo0,retardo1,win_len]=data_init()
  printf("Seleccione un archivo de audio forma *.wav\n");
  [fname,fpath]=uigetfile({"*.wav"});
  audiofile = [fpath fname];
  [audioarray,fs] = audioread(audiofile);
  %%Solicitud de archivo con metadatos
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
  delta0 = input("Determine el valor de la amplitud del eco para los bit 0: ");
  retardo0 = input("Determine el retardo en micro segundos para el valor de bit 0: ")*1e-6;
  delta1 = input("Determine el valor de la amplitud del eco para los bit 1: ");
  retardo1 = input("Determine el retardo en micro segundos para el valor de bit 1: ")*1e-6;
  win_optv = win_opt(audioarray,metadatos,fs);
  printf("El valor recomendado maximo de tiempo por ventana es %f us.\n",win_optv);
  win_len = input("Determine el tiempo por la ventana en micro segundos: ")*1e-6;
  if(win_len > win_optv)
    error("El tiempo asignado por ventana no permite almacenar todos los metadatos");
  endif
  if(length(delta0) == 0) delta0 = ; endif
  if(length(delta1) == 0) delta1 = ; endif
  if(length(retardo0) == 0) retardo0 = ; endif
  if(length(retardo1) == 0) retardo1 = ; endif
  if(length(win_len) == 0) win_len = ; endif
endfunction

function win_optv = win_opt(audioarray,metadatos,fs)
  len_metadatos = length(metadatos);
  len_audioarray = length(audioarray);
  win_optv = ((len_audioarray*(1/fs))/(len_metadatos*8))*1e6;
endfunction