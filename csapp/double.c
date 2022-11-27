#include <stdio.h>

typedef struct s
{
    int a[2];
    double d;
} struct_t;

double fun(int i)
{
    volatile struct_t s;
    s.d = 3.14;
    s.a[i] = 1073741824;
    return s.d;
}

int main()
{
    // printf("%d",fun(2));

    for (int i = 0; i < 5; i++)
    {
        printf("%d,%d\r", i, fun(i));
    }

    return 0;
}