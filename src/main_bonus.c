#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <stdio.h>

#include "libasm.h"

// Macros for convenience
# define ATOI_BASE(s, b)	i = ft_atoi_base(s, b); printf("`%s`[%s] = %d\n", s, b, i);

void    printf_list(t_list *list)
{
    if (!list) 
        return;
    printf("; %s\n", list->data);
    printf_list(list->next);
}

void    printf_int_list(t_list *list)
{
    if (!list) 
        return;
    printf("; %d\n", *(int*)(list->data));
    printf_int_list(list->next);
}

void    ft_lstclear(t_list **list)
{
	t_list	*tmp;

	while (*list)
	{
		tmp = (*list)->next;
		if ((*list)->data)
			free((*list)->data);
		free(*list);
		*list = tmp;
	}
}

void    ft_lstclear_no_free_data(t_list **list)
{
	t_list	*tmp;

	while (*list)
	{
		tmp = (*list)->next;
		free(*list);
		*list = tmp;
	}
}

int main(void) 
{
    int	i = 0;
	printf("- Testing ft_atoi_base\n");
	ATOI_BASE("42", "0123456789")
	ATOI_BASE("0", "0123456789")
	ATOI_BASE("1", "0123456789")
	ATOI_BASE("1215415478", "0123456789")
	ATOI_BASE("-0", "0123456789")
	ATOI_BASE("-1", "0123456789")
	ATOI_BASE("-42", "0123456789")
	ATOI_BASE("--42", "0123456789")
	ATOI_BASE("-+-42", "0123456789")
	ATOI_BASE("-+-+-+42", "0123456789")
	ATOI_BASE("-+-+-+-42", "0123456789")
	ATOI_BASE("-1215415478", "0123456789")
	ATOI_BASE("2147483647", "0123456789")
	ATOI_BASE("2147483648", "0123456789")
	ATOI_BASE("-2147483648", "0123456789")
	ATOI_BASE("-2147483649", "0123456789")
	ATOI_BASE("2a", "0123456789abcdef")
	ATOI_BASE("ff", "0123456789abcdef")
	ATOI_BASE("poney", "poney")
	ATOI_BASE("dommage", "invalid")
	ATOI_BASE("dommage", "aussi invalide")
	ATOI_BASE("dommage", "+toujours")
	ATOI_BASE("dommage", "-stop")
	ATOI_BASE("dommage", "  \t\nca suffit")
	ATOI_BASE("    +42", "0123456789")
	ATOI_BASE("    -42", "0123456789")
	ATOI_BASE("    42", "0123456789")
	ATOI_BASE("  \t\n\r\v\f  42", "0123456789")
	ATOI_BASE("  \t\n\r\v\f  -42", "0123456789")
	ATOI_BASE("42FINIS !", "0123456789")
	ATOI_BASE("-42FINIS !", "0123456789")
	ATOI_BASE("C'est dommage42", "0123456789")
	printf("\n\n");

    t_list	list;
	t_list	list_next;
	t_list	list_last;
	list.data = strdup("foo");
	list.next = &list_next;
	list_next.data = strdup("bar");
	list_next.next = &list_last;
	list_last.data = strdup("fizz");
	list_last.next = NULL;
	printf("-- Testing ft_list_size\n");
	printf("list content:\n");
	printf_list(&list);
	printf("%d (from first %d)\n", ft_list_size(&list), 3);
	printf("%d (from second %d)\n", ft_list_size(&list_next), 2);
	printf("%d (from last %d)\n", ft_list_size(&list_last), 1);
	printf("%d (NULL %d)\n", ft_list_size(NULL), 0);
	printf("\n\n");
	free(list_next.data);
	free(list_last.data);

    printf("-- Testing ft_list_push_front\n");
	t_list	*push_test = &list;
	ft_list_push_front(&push_test, strdup("foo"));
	printf("added: `%s` (next: %p)\n", push_test->data, push_test->next);
	printf("new list size: %d (%d)\n", ft_list_size(push_test), 4);
	free(list.data);
	free(push_test->data);
	free(push_test);
	push_test = NULL;
	ft_list_push_front(&push_test, strdup("bar"));
	printf("added: `%s` (s%p : n%p)\n", push_test->data, push_test, push_test->next);
	ft_list_push_front(&push_test, NULL);
	printf("added: `%s` (s%p : n%p)\n", push_test->data, push_test, push_test->next);
	free(push_test->next->data);
    free(push_test->next);
	push_test->next = NULL;
	ft_list_push_front(&push_test, strdup("fizz"));
	printf("added: `%s` (s%p : n%p)\n", push_test->data, push_test, push_test->next);
    printf("new list size: %d (%d)\n", ft_list_size(push_test), 2);
	ft_lstclear(&push_test);
	printf("\n\n");

    printf("-- Testing ft_list_sort\n");
    t_list	*sort_test = NULL;
    ft_list_push_front(&sort_test, strdup("e"));
    ft_list_push_front(&sort_test, strdup("a"));
    ft_list_push_front(&sort_test, strdup("f"));
    ft_list_push_front(&sort_test, strdup("b"));
    ft_list_push_front(&sort_test, strdup("d"));
    ft_list_push_front(&sort_test, strdup("c"));
    printf("unsorted list:\n");
    printf_list(sort_test);
    ft_list_sort(&sort_test, &ft_strcmp);
    printf("sorted list:\n");
    printf_list(sort_test);
    printf("sort again:\n");
    ft_list_sort(&sort_test, &ft_strcmp);
    printf_list(sort_test);
    ft_lstclear(&sort_test);
	printf("sort NULL:\n");
	ft_list_sort(NULL, &ft_strcmp);
    printf("sort empty:\n");
	ft_list_sort(&push_test, &ft_strcmp);
    printf_list(push_test);
    printf("\n\n");

	printf("-- Testing ft_list_remove_if\n");
	ft_list_push_front(&push_test, strdup("foo"));
	ft_list_push_front(&push_test, strdup("barr"));
	ft_list_push_front(&push_test, strdup("fizz"));
	printf("before:\n");
	printf_list(push_test);
	ft_list_remove_if(&push_test, "", &ft_strcmp, &free);
	printf("nothing removed:\n");
	printf_list(push_test);
	ft_list_remove_if(&push_test, "foo", &ft_strcmp, &free);
	ft_list_remove_if(&push_test, "fizz", &ft_strcmp, &free);
	ft_list_remove_if(&push_test, "barr", &ft_strcmp, &free);
	ft_list_remove_if(&push_test, "", &ft_strcmp, &free);
	printf("after:\n");
	printf_list(push_test);
	ft_lstclear(&push_test);
	printf("\n\n");

	return (0);
}