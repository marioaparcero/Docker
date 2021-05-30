# portainer.sh
sudo curl -L https://downloads.portainer.io/portainer-agent-stack.yml -o portainer-agent-stack.yml
sudo docker stack deploy --compose-file=portainer-agent-stack.yml portainer