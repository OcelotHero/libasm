#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <stdio.h>

#include "libasm.h"

// Macros for convenience
# define STRLEN(x)      printf("`%s` = %lu (%lu)\n", x, ft_strlen(x), strlen(x));
# define STRCMP(a, b)   printf("`%s`:`%s` = %d (%d)\n", a, b, ft_strcmp(a, b), strcmp(a, b));
# define STRCPY(d, s)   printf("`%s` (`%s`)\n", ft_strcpy(d, s), s);
# define WRITE(s, x)    printf("^%ld (`%s`:%ld)\n", ft_write(STDOUT_FILENO, s, x), s, x);
# define READ(b, x)     r = ft_read(STDIN_FILENO, buffer, x); printf("`%s`:%ld\n", buffer, r);
# define DUP(s)         tmp = ft_strdup(s); printf("`%s` (`%s`)\n", tmp, s); if(tmp) free(tmp); tmp = NULL;

// Test cases
int main(void)
{
    int     i;
    long    r;
    char    buffer[100];
    char    *tmp;
    char    *tmp2;

    r = 0;
    i = 0;
    while (i < 100)
        buffer[i++] = 0;

    printf("-- Testing ft_strlen \n");
    STRLEN("")
    STRLEN("foo")
    STRLEN("foobar")
    STRLEN("0123456789abcdef")
    STRLEN("42")
    STRLEN("1")
    printf("\n\n");

    printf("-- Testing ft_strcmp \n");
    STRCMP("", "")
    STRCMP("foo", "foo")
    STRCMP("", "foo")
    STRCMP("foo", "")
    STRCMP("foo", "foobar")
    printf("\n\n");

    printf("-- Testing ft_strcpy \n");
    STRCPY(buffer, "foo");
    STRCPY(buffer, "");
    STRCPY(buffer, "lorem ipsum dolor sit amet");
    printf("\n\n");

    printf("-- Testing ft_write \n");
    WRITE("foos", 4L)
    WRITE("foosbars", 4L)
    WRITE("foosbar", 8L)
    WRITE("foos", 2L)
    printf("\n\n");

    printf("-- Testing ft_read \n");
    READ(buffer, 50)
    READ(buffer, 25)
    READ(buffer, 4)
    READ(buffer, 26)
    READ(buffer, 14)
    READ(buffer, 0)
    printf("\n\n");

    printf("-- Testing ft_strdup \n");
    tmp2 = ft_strdup("foo");
    DUP(tmp2)
    free(tmp2);
    DUP("foobar")
    DUP("lorem ipsum dolor sit amet")
    DUP("")
    printf("\n\n");

    return (0);
}