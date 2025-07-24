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

DATA_PATH = $(HOME)/data
VOLUMES = mariadb wordpress

COMPOSE = docker compose -f
YML_FILE = srcs/docker-compose.yml

all: header create_volumes build up

header:
	@echo ""
	@echo "                                             "
	@echo "                                             "
	@echo "                \e[5m\e[38;5;177m@@@@@@@@@@@@@@@\e[0m              "
	@echo "            \e[5m\e[38;5;213m@@\e[0m                   \e[5m\e[38;5;177m@@\e[0m          "
	@echo "         \e[5m\e[38;5;213m@\e[0m        \e[5m\e[38;5;228m@@@@@@@@@@@\e[0m        \e[5m\e[38;5;141m@\e[0m       "
	@echo "       \e[5m\e[38;5;213m@\e[0m       \e[5m\e[38;5;228m@@\e[0m              \e[5m\e[38;5;226m@@\e[0m      \e[5m\e[38;5;141m@\e[0m     "
	@echo "      \e[5m\e[38;5;213m@\e[0m     \e[5m\e[38;5;228m@\e[0m       \e[5m\e[38;5;71m@@@@@@@\e[0m        \e[5m\e[38;5;226m@\e[0m     \e[5m\e[38;5;141m@\e[0m   "
	@echo "     \e[5m\e[38;5;213m@\e[0m    \e[5m\e[38;5;230m@\e[0m     \e[5m\e[38;5;71m@@\e[0m           \e[5m\e[38;5;71m@@      \e[5m\e[38;5;226m@\e[0m    \e[5m\e[38;5;141m@\e[0m  "
	@echo "    \e[5m\e[38;5;213m@\e[0m    \e[5m\e[38;5;230m@\e[0m    \e[5m\e[38;5;43m@\e[0m      \e[5m\e[38;5;32m@@@@@\e[0m      \e[5m\e[38;5;71m@\e[0m     \e[5m\e[38;5;226m@\e[0m    \e[5m\e[38;5;141m@\e[0m "
	@echo "    \e[5m\e[38;5;213m@\e[0m    \e[5m\e[38;5;230m@\e[0m   \e[5m\e[38;5;43m@\e[0m     \e[5m\e[38;5;27m@\e[0m       \e[5m\e[38;5;32m@\e[0m      \e[5m\e[38;5;71m@\e[0m    \e[5m\e[38;5;226m@\e[0m    \e[5m\e[38;5;141m@\e[0m"
	@echo "    \e[5m\e[38;5;213m@\e[0m    \e[5m\e[38;5;230m@\e[0m   \e[5m\e[38;5;43m@\e[0m    \e[5m\e[38;5;27m@     @\e[0m    \e[5m\e[38;5;32m@\e[0m    \e[5m\e[38;5;149m@\e[0m    \e[5m\e[38;5;226m@\e[0m    \e[5m\e[38;5;141m@\e[0m"
	@echo "    \e[5m\e[38;5;213m@\e[0m    \e[5m\e[38;5;230m@\e[0m   \e[5m\e[38;5;43m@\e[0m     \e[5m\e[38;5;27m@     @\e[0m   \e[5m\e[38;5;32m@\e[0m    \e[5m\e[38;5;149m@\e[0m    \e[5m\e[38;5;226m@\e[0m    \e[5m\e[38;5;141m@\e[0m"
	@echo "    \e[5m\e[38;5;221m@\e[0m    \e[5m\e[38;5;230m@\e[0m    \e[5m\e[38;5;43m@\e[0m      \e[5m\e[38;5;27m@@@\e[0m     \e[5m\e[38;5;32m@\e[0m    \e[5m\e[38;5;149m@\e[0m    \e[5m\e[38;5;226m@\e[0m    \e[5m\e[38;5;141m@\e[0m"
	@echo "     \e[5m\e[38;5;221m@\e[0m    \e[5m\e[38;5;230m@\e[0m     \e[5m\e[38;5;43m@\e[0m           \e[5m\e[38;5;32m@\e[0m    \e[5m\e[38;5;149m@\e[0m     \e[5m\e[38;5;220m@\e[0m    \e[5m\e[38;5;141m@\e[0m"
	@echo "      \e[5m\e[38;5;221m@\e[0m     \e[5m\e[38;5;186m@\e[0m      \e[5m\e[38;5;43m@@@@@@@\e[0m      \e[5m\e[38;5;149m@\e[0m     \e[5m\e[38;5;220m@\e[0m     \e[5m\e[38;5;135m@\e[0m"
	@echo " \e[5m\e[38;5;93m@\e[0m     \e[5m\e[38;5;221m@\e[0m      \e[5m\e[38;5;186m@@\e[0m             \e[5m\e[38;5;149m@@\e[0m      \e[5m\e[38;5;220m@\e[0m     \e[5m\e[38;5;135m@\e[0m "
	@echo "  \e[5m\e[38;5;93m@\e[0m       \e[5m\e[38;5;221m@\e[0m       \e[5m\e[38;5;186m@@@@@\e[0m\e[5m\e[38;5;149m@@@@\e[0m       \e[5m\e[38;5;220m@\e[0m       \e[5m\e[38;5;135m@\e[0m  "
	@echo "    \e[5m\e[38;5;93m@\e[0m        \e[5m\e[38;5;221m@@@\e[0m              \e[5m\e[38;5;220m@@\e[0m        \e[5m\e[38;5;135m@\e[0m    "
	@echo "      \e[5m\e[38;5;93m@\e[0m          \e[5m\e[38;5;221m@@@\e[0m\e[5m\e[38;5;220m@@@@@@@@@\e[0m        \e[5m\e[38;5;135m@\e[0m       "
	@echo "          \e[5m\e[38;5;93m@@\e[0m                     \e[5m\e[38;5;135m@@\e[0m          "
	@echo "              \e[5m\e[38;5;93m@@@@\e[0m\e[5m\e[38;5;129m@@@@@@@@@@\e[0m\e[5m\e[38;5;135m@@@\e[0m              "
	@echo "                                             "
	@echo "                                             " 
	@echo "            \e[5m\e[38;5;28mWELCOME TO INCEPTION\e[0m          " 
	@echo "                                             "
	@echo "                                             "

create_volumes:
	@echo "$(YELLOW)$(UNDERLINED)$(BOLD)1/3: Creating volumes$(END)"
	@echo ""

	@if [ ! -d "$(DATA_PATH)" ] || [ ! -d "$(DATA_PATH)/wordpress" ] || [ ! -d "$(DATA_PATH)/mariadb" ]; then \
		mkdir -p $(DATA_PATH)/wordpress; \
		mkdir -p $(DATA_PATH)/mariadb; \
	fi
	@sudo chown -R $(USER):$(USER) $(DATA_PATH)/wordpress
	@sudo chown -R $(USER):$(USER) $(DATA_PATH)/mariadb
	@sudo chmod 755 $(DATA_PATH)/wordpress
	@sudo chmod 755 $(DATA_PATH)/mariadb

	@echo "$(GREEN)Volumes successfully created ✅$(END)"
	@echo ""

build:
	@echo "$(YELLOW)$(UNDERLINED)$(BOLD)2/3: Building containers$(END)"
	@echo ""

	@$(COMPOSE) $(YML_FILE) build && \
	echo "$(GREEN)$(BOLD)Containers successfully built ✅$(END)" || echo "$(RED)$(BOLD)Building containers error ❌$(END)"
	@echo ""

up:
	@echo "$(YELLOW)$(UNDERLINED)$(BOLD)3/3: Starting containers$(END)"
	@echo ""

	@$(COMPOSE) $(YML_FILE) up -d && \
	echo "$(GREEN)$(BOLD)Containers successfully started ✅$(END)" || echo "$(RED)$(BOLD)Starting containers error ❌$(END)"
	@echo ""

down:
	@echo "$(YELLOW)$(UNDERLINED)Stopping containers$(END)"
	@echo ""

	@$(COMPOSE) $(YML_FILE) down && \
	echo "$(GREEN)$(BOLD)Containers successfully stopped ✅$(END)" || echo "$(RED)$(BOLD)Stopping containers error ❌$(END)"
	@echo ""

clean: down
	@echo "🧹 $(YELLOW)$(UNDERLINED)Cleaning$(END)"

	@docker system prune -a -f

	@echo ""
	@echo "$(GREEN)Project cleaned ✅$(END)"
	@echo ""

fclean: clean
	@echo "🧹 $(YELLOW)$(UNDERLINED)Deep cleaning$(END)"

	@for dir in $(VOLUMES); do \
		sudo rm -rf $(DATA_PATH)/$$dir; \
	done
	@sudo rm -rf $(DATA_PATH)
	@if [ -n "$(shell docker volume ls -q)" ]; then \
		docker volume rm $(shell docker volume ls -q); \
	fi

	@echo ""
	@echo "$(GREEN)Project totally cleaned ✅$(END)"
	@echo ""

re: fclean all

.PHONY: all header create_volumes build up down clean fclean re