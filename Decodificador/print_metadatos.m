%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Devuelve una variable tipo array NxM donde:
%%  -N = Cantidad de ventanas creadas
%%  -M = Cantidad de elementos por ventana
%% La función tiene como parametros:
%%  - audioarray = Array con elementos de audioarray
%%  - win_len = Cantidad de elementos por ventana
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function metadatos_recuperados = print_metadatos(metadatos)
  asteriscos = findstr (metadatos, "*");
  arrobas = findstr (metadatos, "@");
  %%title
  if(metadatos(arrobas(1)+1:asteriscos(1)-1) == "!")
    cancion = "Desconocido";
  else
    cancion = metadatos(arrobas(1)+1:asteriscos(1)-1);
  endif
  %singer
  if(metadatos(asteriscos(1)+1:asteriscos(2)-1) == "!")
    singer = "Desconocido";
  else
    singer = metadatos(asteriscos(1)+1:asteriscos(2)-1);
  endif
  %Autor
  if(metadatos(asteriscos(2)+1:asteriscos(3)-1) == "!")
    autor = "Desconocido";
  else
    autor = metadatos(asteriscos(2)+1:asteriscos(3)-1);
  endif
  %Album
  if(metadatos(asteriscos(3)+1:asteriscos(4)-1) == "!")
    album = "Desconocido";
  else
    album = metadatos(asteriscos(3)+1:asteriscos(4)-1);
  endif
  %year
  if(metadatos(asteriscos(4)+1:asteriscos(5)-1) == "!")
    year = "Desconocido";
  else
    year = metadatos(asteriscos(4)+1:asteriscos(5)-1);
  endif
  %guestsinger
  if(metadatos(asteriscos(5)+1:asteriscos(6)-1) == "!")
    guestsinger = "Desconocido";
  else
    guestsinger = metadatos(asteriscos(5)+1:asteriscos(6)-1);
  endif
  %productor
  if(metadatos(asteriscos(6)+1:arrobas(2)-1) == "!")
    productor = "Desconocido";
  else
    productor = metadatos(asteriscos(6)+1:arrobas(2)-1);
  endif
  printf("El nombre de la cancion es: %s\n",cancion);
  printf("El nombre del artista es: %s\n",singer);
  printf("El nombre del autor es: %s\n",autor);
  printf("El nombre del album es: %s\n",album);
  printf("El año de publicacion es: %s\n",year);
  printf("Los caantantes invitados son: %s\n",guestsinger);
  printf("El productor es: %s\n",productor);
  metadatos_recuperados = metadatos(arrobas(1):arrobas(2));
endfunction