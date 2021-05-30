
# Neceario swarm previo
# sudo docker swarm init 

# Creamos el config. Otra opción es usarlo como externo el fichero compose
sudo docker config create nginx_root_doc index.html

# sudo docker service create --name web \
#   --config source=nginx_root_doc,target=/usr/share/nginx/html/index.html \
#   --publish 8080:80 nginx:alpine
sudo docker stack deploy -c compose-config.yml test


# Probamos
# curl -i http://localhost:8080/

# docker stack rm test
# docker config rm nginx_root_doc