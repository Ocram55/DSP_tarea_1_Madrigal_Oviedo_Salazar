%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Iniciando Datos
% Las variables de salida son:
% - audioarray = Array de audio
% - fs = frecuencia de muestreo de audio
% - metadatos = Datos a codificar en audio en el siguiente formato:Titulo*Cantante*Autor*Album*
% - delta0 = Amplitud de eco del bit 0
% - retardo0 = Cantidad de muestras de retardo para eco del bit 0
% - delta1 = Amplitud de eco del bit 1
% - retardo1 = Cantidad de muestras de retardo eco del bit 1
% - win_len = Cantidad de muestras por ventana
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [audioarray,fs,audio, channel,fpath_out,metadatos,delta0,delta1,retardo0,retardo1, win_len]=data_init()
  printf("\n----------------------------------------------------------------\n");
  printf("***** Codificador de audio con el metodo Echo Hiding *****\n\n");
  printf("- Primero sera necesario introducir los directorios del archivo de audio de entrada y el de salida.\n");
  printf("- El archivo de audio de salida tendra el nombre por defecto audio_output.wav.\n");
  printf("- Posterior se introduciran los valores de metadatos.\n");
  printf("- Finalmente, se le pedira introducir los parametros para realizar la codificacion.\n");
  printf("- En el caso de encontrar un valor no valido no se realizara la codificacion.\n");
  printf("----------------------------------------------------------------\n \n");
  %%-------- Directorios -----------%%
  printf("\n----------------------------------------------------------------\n");
  printf("***** Archivo de audio a codificar *****\n");
  printf("----------------------------------------------------------------\n \n");
  audiofile = input("Escriba el path de la cancion de la forma /it/is/the/file.wav : ",'s');
  [audio,fs] = audioread(audiofile);
  %info = audioinfo(audiofile);
  printf("Seleccione el canal a codificar presionando\n** 1 para Canal Izquierdo\n** 2 para Canal derecho\n");
  printf("En el caso de presionar ENTER se definira por defecto Canal Izquierdo\n");
  channel = input("Seleccione el canal a codificar : ");
  if(channel != 1 && channel != 2)
    error("***** Canal incorrecto *****");
  endif
  if(channel == 1)
    printf("***** Canal Izquierdo escogido *****\n");
  endif
  if(channel == 2)
    printf("***** Canal Derecho escogido *****\n");
  endif
  if(length(channel) == 0)
    printf("***** Canal Izquierdo escogido *****\n");
    channel = 1;
  endif 
  audioarray = audio(:,channel);
  printf("\n----------------------------------------------------------------\n");
  printf("***** Directorio de salida de audio codificado *****\n");
  printf("----------------------------------------------------------------\n \n");
  fpath_out = input("Si escribe ENTER se guardara en el directorio actual. \nEscriba el path donde guardar la cancion de la forma /it/is/the/:",'s');
  
  %%-------- Metadatos-----------%%
  printf("\n----------------------------------------------------------------\n");
  printf("***** Metadatos de la cancion *****\nSi desea dejar algun espacio sin llenar solo presione ENTER.\nSi deja todos los espacios en blanco no se iniciara codificacion.\n");
  printf("----------------------------------------------------------------\n \n");
  title = input("Escriba el nombre de la cancion:",'s');
  singer = input("Escriba el nombre del artista principal de la cancion: ",'s');
  autor = input("Escriba el nombre del autor de la cancion: ",'s');
  album = input("Escriba el nombre del album al que pertenece la cancion: ",'s');
  year = input("Escriba el año de publicación de la cancion: ",'s');
  guestsinger = input("Escriba el nombre de los artistas invitados de la cancion: ",'s');
  productor = input("Escriba el nombre del productor de la cancion: ",'s');
  if((length(title) == 0) && (length(singer) == 0) && (length(autor) == 0) && (length(album) == 0) && (length(year) == 0) && (length(guestsinger) == 0) && (length(productor) == 0))
    error("***** Metadatos insuficientes *****");
   endif
  if(length(title) == 0) title = ["!"]; endif
  if(length(singer) == 0) singer = ["!"]; endif
  if(length(autor) == 0) autor = ["!"]; endif
  if(length(album) == 0) album = ["!"]; endif
  if(length(year) == 0) year = ["!"]; endif
  if(length(guestsinger) == 0) guestsinger = ["!"]; endif
  if(length(productor) == 0) productor = ["!"]; endif
  
  metadatos=["@" title "*" singer "*" autor "*" album "*" year "*" guestsinger "*" productor "@"];
  
  %%Solicitud de parametros para codificacion
  printf("\n----------------------------------------------------------------\n");
  printf("***** Parametros para codificacion de audio ***** \nSi desea dejar algun espacio sin llenar solo presione ENTER.\n");
  printf("En el caso de no indicar un valor se asignara un valor predeterminado.\n");
  printf("Los valores de retardo deben ser mayores a %f us.\n",(1/fs)*1e6);
  printf("----------------------------------------------------------------\n \n");
  delta0 = input("Determine el valor, en porcentaje, de la atenuacion del eco para los bit 0: ")/100;
  retardo0 = round((input("Determine el retardo en micro segundos para el valor de bit 0: ")*1e-6)*fs);
  if(retardo0 == 0) 
    error("***** Retardo no valido *****");
  endif
  delta1 = input("Determine el valor, en porcentaje, de la atenuacion del eco para los bit 1: ")/100;
  retardo1 = round((input("Determine el retardo en micro segundos para el valor de bit 1: ")*1e-6)*fs);
  if(retardo1 == 0) 
    error("***** Retardo no valido *****");
  endif
  win_optv = win_opt(audioarray,metadatos,fs);
  printf("*******************************************************************\n");
  printf("El valor recomendado maximo de tiempo por ventana es %f us.\n",win_optv*1e6);
  printf("*******************************************************************\n");
  win_len = round((input("Determine el tiempo por la ventana en micro segundos: ")*1e-6)*fs);
  if(win_len == 0) 
    error("***** Tamaño de ventana no valido *****");
  endif
  if(win_len/fs > win_optv)
    error("El tiempo asignado por ventana no permite almacenar todos los metadatos");
  endif
  if(length(delta0) == 0) delta0 =0.7; else  delta0 =1 - delta0; endif
  if(length(delta1) == 0) delta1 = 0.7;  else  delta1 =1 - delta1; endif
  if(length(retardo0) == 0) retardo0 =round(2000*1e-6*fs) ; endif
  if(length(retardo1) == 0) retardo1 = round(3500*1e-6*fs); endif
  if(length(win_len) == 0) win_len = round(14000*1e-6*fs) ; endif
endfunction

function win_optv = win_opt(audioarray,metadatos,fs)
  len_metadatos = length(metadatos);
  len_audioarray = length(audioarray);
  win_optv = ((len_audioarray*(1/fs))/(len_metadatos*8));
endfunction