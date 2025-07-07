NAME = inception

all: create_volumes build up

header:

create_volumes:

build:
	@docker-compose -f srcs/docker-compose.yml build

up:

down:
	@docker-compose -f srcs/docker-compose.yml down

clean: down
	@docker system prune -a -f

fclean: clean

re: fclean all

.PHONY: all header build up create_volumes down clean fclean re