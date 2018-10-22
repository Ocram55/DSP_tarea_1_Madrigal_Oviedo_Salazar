%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Devuelve una variable tipo array NxM donde:
%%  -N = Cantidad de ventanas creadas
%%  -M = Cantidad de elementos por ventana
%% La función tiene como parametros:
%%  - audioarray = Array con elementos de audioarray
%%  - win_len = Cantidad de elementos por ventana
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ventanas = windows(audioarray,win_len)
  printf("\n----------------------------------------------------------------\n");
  printf("Inicia proceso de enventanado.\n");
  printf("----------------------------------------------------------------\n \n");
  len_audiofile = length(audioarray);
  win_total= ceil(len_audiofile/win_len);
  win_array(win_total,win_len)=0;
  printf("Total de ventana %d\n",win_total);
  for x = 1:win_total
    for y = 1:win_len
      if(((x-1)*win_len+y)>=len_audiofile)
        win_array(x,y)=0;
      else
        win_array(x,y)=audioarray((x-1)*win_len+y);
      endif
    endfor
  endfor
  ventanas=win_array;
  printf("******Termino proceso de enventanado*****\n");
end