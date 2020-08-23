#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int shc(char* ca) {
    int h = 0;
      
    for (int i = 0; i < strlen(ca)-1; i++) 
    {
        h = 31 * h + ca[i];
    }

    return h;
}

int shcC(char* ca) 
{
    int h = 0, tam=0;

    while(ca[tam]!='\0')
        tam++;
      
    for (int i = 0; i < tam-1; i++) 
    {
        h = 31 * h + ca[i];
    }

    return h;
}

void main() {

    char * a = (char *) malloc(sizeof(char)*5);

    printf("Introduce una cadena: ");
    getstr(a);

    printf("┤%s├\n", a);

    printf("El hashcode de ┤%s├ es ┤%d├\n", a, shc(a));
    //printf("El hashcode de ┤%s├ es ┤%d├ en CUDA\n", a, shcC(a));

}