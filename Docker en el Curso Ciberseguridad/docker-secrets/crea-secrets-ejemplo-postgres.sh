# https://dzone.com/articles/introduction-to-docker-secrets 
echo "myuser" | sudo docker secret create pg_user -
echo "mysupersecretpassword" | sudo docker secret create pg_password -
echo "mydatabase" | sudo docker secret create pg_database -