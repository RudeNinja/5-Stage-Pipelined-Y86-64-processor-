#include<stdio.h>
void main()
{
    int a[2][2], b[2][2],c[2][2];

    

    for (int x = 0; x < 2; x++)
    {
        for (int y = 0; y < 2; y++)
        {
            c[x][y] = a[x][y] + b[x][y];
        }
       
    }

} 