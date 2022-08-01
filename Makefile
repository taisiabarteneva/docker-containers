all :
	@docker-compose -f ./srcs/docker-compose.yml up

down :
	@docker-compose -f ./srcs/docker-compose.yml down

re :
	@docker-compose -f ./srcs/docker-compose.yml up --build 

clean :
	@docker stop $$(docker ps -qa); \
	docker rm $$(docker ps -qa); \
	docker rmi -f $$(docker images -qa); \
	docker volume rm $$(docker volume ls -q); \
	docker network rm $$(docker network ls -q)

.PHONY: all re down clean 

# ---------------------------------------- links
# https://wurrigon.42.fr/
# https://wurrigon.42.fr/wp-login
# https://wurrigon.42.fr/wp-admin