# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jdorazio <jdorazio@student.42madrid.com    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/09/19 15:33:02 by jdorazio          #+#    #+#              #
#    Updated: 2024/09/28 15:48:26 by jdorazio         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = getnextline.a

#  find *.c | xargs echo

C_FILES =  get_next_line.c get_next_line_utils.c
C_FILES_BONUS = get_next_line_bonus.c get_next_line_utils_bonus.c

O_FILES = $(C_FILES:.c=.o)
O_FILES_BONUS = $(C_FILES_BONUS:.c=.o)

INCLUDE = get_next_line.h
INCLUDE_BONUS = get_next_line_bonus.h

CC = cc
CFLAGS = -Wall -Werror -Wextra -D BUFFER_SIZE=42
AR = ar rcs

all: $(NAME)

$(NAME): $(O_FILES) $(INCLUDE)
		$(AR) $(NAME) $(O_FILES)

bonus: $(O_FILES) $(O_FILES_BONUS) $(INCLUDE) $(INCLUDE_BONUS)
		@$(AR) $(NAME) $(O_FILES) $(O_FILES_BONUS)

clean:
	rm -f $(O_FILES) $(O_FILES_BONUS)

fclean: clean
	rm -f $(NAME)

re: fclean bonus

.PHONY: all clean fclean re
