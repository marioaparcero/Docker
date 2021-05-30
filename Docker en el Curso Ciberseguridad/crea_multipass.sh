#!/bin/bash
# crea_multipass.sh 
# recibe los nombres de los nodos

memoria=1GB #512M
cpu=1

for nodo in $*
do
  if [ $nodo = 'manager' ]; then
    memoria=2GB
  fi

  multipass launch -v -n $nodo  -m $memoria -c $cpu  # -m 512M  

  # Instalar docker 
  #     (versión de snap no funciona con docker stack deploy  # multipass exec -v $nodo  sudo snap install docker)
  #  Se usa script de instalación docker
  multipass exec $nodo -- curl -fsSL https://get.docker.com -o get-docker.sh
  multipass exec $nodo -- sudo sh get-docker.sh
  multipass exec $nodo -- sudo usermod -aG docker ubuntu
  
done

