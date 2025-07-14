NAME = inception

RED = \033[0;31m
GREEN = \033[0;32m
YELLOW = \033[0;33m
BLUE = \033[0;34m
MAGENTA = \033[0;35m
CYAN = \033[0;36m

UNDERLINED = \033[4m
BOLD = \033[1m

END = \033[0m

DATA_PATH = $(HOME)/lmatkows/data
VOLUMES = mariadb wordpress

all: header create_volumes build up

header:
	@echo ""
	@echo "$(CYAN)$(BOLD)WELCOME TO INCEPTION$(END)$(END)"
	@echo ""

create_volumes:
	@echo "$(YELLOW)$(UNDERLINED)$(BOLD)1/3:$(END) Creating volumes$(END)$(END)"
	@echo ""

	@if [ ! -d "$(DATA_PATH)" ]; then \
		mkdir -p $(DATA_PATH)/wordpress && \
		mkdir -p $(DATA_PATH)/mariadb; \
	fi
	@sudo chown -R $(USER):$(USER) $(DATA_PATH)/wordpress
	@sudo chown -R $(USER):$(USER) $(DATA_PATH)/mariadb
	@sudo chmod 755 $(DATA_PATH)/wordpress
	@sudo chmod 755 $(DATA_PATH)/mariadb

	@echo "$(GREEN)Volumes successfully created ✅$(END)"

build:
	@echo "$(YELLOW)$(UNDERLINED)$(BOLD)2/3:$(END) Building containers$(END)$(END)"
	@echo ""

	@docker-compose -f srcs/docker-compose.yml build && \
	echo "$(GREEN)$(BOLD)Containers successfully built ✅$(END)$(END)" || echo "$(RED)$(BOLD)Building containers error ❌$(END)$(END)"

up:
	@echo "$(YELLOW)$(UNDERLINED)$(BOLD)3/3:$(END) Starting containers$(END)$(END)"
	@echo ""

	@docker-compose -f srcs/docker-compose.yml up -d && \
	echo "$(GREEN)$(BOLD)Containers successfully started ✅$(END)$(END)" || echo "$(RED)$(BOLD)Starting containers error ❌$(END)$(END)"

down:
	@echo "$(YELLOW)$(UNDERLINED)Stopping containers$(END)$(END)"
	@echo ""

	@docker-compose -f srcs/docker-compose.yml down && \
	echo "$(GREEN)$(BOLD)Containers successfully stopped ✅$(END)$(END)" || echo "$(RED)$(BOLD)Stopping containers error ❌$(END)$(END)"

clean: down
	@echo "🧹 $(YELLOW)$(UNDERLINED)Cleaning$(END)$(END)"

	@docker system prune -a -f

	@echo ""
	@echo "$(GREEN)Project cleaned ✅$(END)"

fclean: clean
	@echo "🧹 $(YELLOW)$(UNDERLINED)Deep cleaning$(END)$(END)"

	@for dir in $(VOLUMES); do \
		sudo rm -rf $(DATA_PATH)/$$dir; \
	done
	@sudo rm -rf $(DATA_PATH)
	@if [ -n "$(shell docker volume ls -q)" ]; then \
		docker volume rm $(shell docker volume ls -q); \
	fi

	@echo ""
	@echo "$(GREEN)Project totally cleaned ✅$(END)"

re: fclean all

.PHONY: all header create_volumes build up down clean fclean re