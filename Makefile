NAME	= libasm.a
TEST	= test
TEST_B	= test_bonus

AS		= nasm

CC		= cc
CFLAGS	= -Wall -Wextra

DFLAGS	= -MMD -MP

ARFLAGS	= rcs

RM		= rm -f

SRC		= ft_strlen ft_strcpy ft_strcmp ft_write ft_read ft_strdup
SRC_B	= ft_atoi_base ft_list_push_front ft_list_size ft_list_sort ft_list_remove_if

OBJ_DIR = obj

OBJS	= $(addprefix $(OBJ_DIR)/, $(addsuffix .o, $(SRC)))
OBJS_B	= $(addprefix $(OBJ_DIR)/, $(addsuffix .o, $(SRC_B)))

SRC_DIR	= src
VPATH	+= %.c $(SRC_DIR)
VPATH	+= %.s $(SRC_DIR)/mandatory $(SRC_DIR)/bonus


INCL	= inc

OSNAME	= $(shell uname -s)
ifeq (${OSNAME}, Darwin)
	ASFLAGS	+= -f macho64 -DAPPLE
else
	ASFLAGS	+= -f elf64
endif

all:			$(NAME)

$(NAME):		$(OBJS)
				ar $(ARFLAGS) $(NAME) $(OBJS)

${OBJ_DIR}/%.o: %.c | ${OBJ_DIR}
				${CC} ${DFLAGS} ${CFLAGS} -c $< -o $@ -I ${INCL}

${OBJ_DIR}/%.o: %.s | ${OBJ_DIR}
				${AS} ${ASFLAGS} $< -o $@ -I ${INCL}

${OBJ_DIR}:
				mkdir -p ${OBJ_DIR}


clean:
				rm -rf $(OBJS) $(OBJS_B)

fclean:			clean
				rm -rf $(NAME) $(TEST) $(TEST_B) $(OBJ_DIR)

re:				fclean $(NAME)

test:			$(NAME)
				$(CC) $(CFLAGS) -o $(TEST) $(SRC_DIR)/main.c -L . -l asm -I $(INCL)
				./$(TEST) < Makefile

bonus:			$(OBJS) $(OBJS_B)
				ar $(ARFLAGS) $(NAME) $(OBJS) $(OBJS_B)

test_bonus:		bonus
				$(CC) $(CFLAGS) -o $(TEST_B) $(SRC_DIR)/main_bonus.c -L . -l asm -I $(INCL)
				./$(TEST_B)

.PHONY:			clean fclean re test bonus test_bonus
