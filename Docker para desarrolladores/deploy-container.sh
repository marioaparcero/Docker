#!/bin/bash
#Situación: Tengo el siguiente fichero "bash" para lanzar nº contenedores en base a una imagen y construcción de configuraciones automáticas. 
#Cada contendor publica 21 servicios (puerto 10000 al 10020) y realizan notificaciones a una IP concreta (HOST), 
#junto a la notificación cada contenedor indica al HOST cual es su IP y puerto de publicación, para que el HOST realice una comunicación en sentido HOST => contenedor => puerto.
#El HOST conoce la IP y puertos de cada contenedor lanzado, pero no puede acceder a la IP facilitada por estar en la red brich.
#¿Se puede acceder desde un HOST que no conforma la infraestructura Docker a la ip y puerto de un contenedor?
clear
echo ===================================
echo = Lanzador de Contenedores INBOX. =
echo = Imagen base java:latest =
echo ===================================
echo
echo
docker images
echo
echo
echo
echo "Indicar que imagen se desea utilizar, ejemplo &quot;inbox:latest&quot;: "
read NAME_IMAGES
echo -n "Introducir el numero de Contenedores a desplegar: "
read NUM_CONTENEDORES
echo -n "Introducir la IP servidor Armadillo al que conectara: "
read HOST_ARMADILLO
echo Matando y borrado primero de todo contenedor pre lanzado:
for b in $(seq 1 $NUM_CONTENEDORES); do
echo matar Contenedor &quot;inbox$b&quot;
docker kill inbox$b
echo Borrando Contenedor &quot;inbox$b&quot;
docker rm inbox$b
echo
echo
done
echo construllendo y lanzando Contenedores:
grupo=$((20))
anterior=$((9980))
cp /dev/null IPs.txt
for i in $(seq 1 $NUM_CONTENEDORES); do
echo Lanzando Contenedor inbox$i
puerto=$(($anterior + $grupo))
docker run -p $puerto-$(($puerto + 20)):10000-10020 -d -ti --name inbox$i --add-host armadillo:$HOST_ARMADI
LLO $NAME_IMAGES
anterior=$(($puerto + 1))
echo inbox$i >> IPs.txt
docker inspect -f "{{.NetworkSettings.IPAddress}}" inbox$i >> IPs.txt
docker inspect -f"{{.NetworkSettings.MacAddress}}" inbox$i >> IPs.txt
done
echo
echo
echo IPs asignadas a cada contenedor INBOX:
more IPs.txt
