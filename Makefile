NAME = inception

RED = \033[0;31m
GREEN = \033[0;32m
YELLOW = \033[0;33m
BLUE = \033[0;34m
MAGENTA = \033[0;35m
CYAN = \033[0;36m
ENDCOL = \033[0m

VOL_PATH = $(HOME)/lmatkows/data
VOL_NAMES = mariadb nginx wordpress

all: header create_volumes build up

header:
	@echo ""
	@echo "$(CYAN)WELCOME TO INCEPTION$(ENDCOL)"
	@echo ""

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