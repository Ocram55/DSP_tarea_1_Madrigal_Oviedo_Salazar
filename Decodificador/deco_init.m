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
function [audioarray, fs, retardo0, retardo1, win_len]=deco_init()
  printf("\n----------------------------------------------------------------\n");
  printf("***** Decodificador de audio con el metodo Echo Hiding *****\n\n");
  printf("- Primero sera necesario introducir los directorios del archivo de audio de entrada.\n");
  printf("- Seguidamente debera introducir los parametros para realizar la decodificacion.\n");
  printf("- En el caso de encontrar un valor no valido no se realizara la decodificacion.\n");
  printf("----------------------------------------------------------------\n \n");
  %%-------- Directorios -----------%%
  printf("\n----------------------------------------------------------------\n");
  printf("***** Archivo de audio a codificar *****\n");
  printf("----------------------------------------------------------------\n \n");
  audiofile = input("Escriba el path del audio a decodificar de la forma /it/is/the/file.wav : ",'s');
  [audio,fs] = audioread(audiofile);
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

  %%Solicitud de parametros para codificacion
  printf("\n----------------------------------------------------------------\n");
  printf("***** Parametros para codificacion de audio ***** \nSi desea dejar algun espacio sin llenar solo presione ENTER.\n");
  printf("En el caso de no indicar un valor se asignara un valor predeterminado.\n");
  printf("Los valores de retardo deben ser mayores a %f us.\n",(1/fs)*1e6);
  printf("----------------------------------------------------------------\n \n");
  retardo0 = round((input("Determine el retardo en micro segundos para el valor de bit 0: ")*1e-6)*fs);
  if(retardo0 == 0) 
    error("***** Retardo no valido *****");
  endif
  retardo1 = round((input("Determine el retardo en micro segundos para el valor de bit 1: ")*1e-6)*fs);
  if(retardo1 == 0) 
    error("***** Retardo no valido *****");
  endif
  if(length(retardo0) == 0) retardo0 =round(2000*1e-6*fs) ; endif
  if(length(retardo1) == 0) retardo1 = round(3500*1e-6*fs); endif
  win_len = round((input("Determine el tiempo por la ventana en micro segundos: ")*1e-6)*fs);
  if(win_len == 0) 
    error("***** Tamaño de ventana no valido *****");
  endif
  if(win_len/fs >max(retardo0,retardo1))
    error("***** El tiempo asignado por ventana no es valido. *****");
  endif
  if(length(win_len) == 0) win_len = round(14000*1e-6*fs) ; endif
endfunction