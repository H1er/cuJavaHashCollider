#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* getstr(FILE* f, char* str)
{
    char l;
    size_t size = 20;
    int pos = 0;
    str = malloc(size);
    
    while(l != '\0' && l != '\n')
    {
        scanf("%c", &l);
        str[pos] = l;
        pos++;

         if(pos > size)
        {
            char* prev = str;
            str = realloc(str, size*2);
        }
    }

    fflush(stdin);
    
    return realloc(str, pos);
}

int shc(char* ca) 
{
    int h = 0;
      
    for (int i = 0; i < strlen(ca)-1; i++) 
    {
        h = 31 * h + ca[i];
    }

    return h;
}

char * id2str(int n) 
{
    //Convert the id of the thread into the string in order to be checked
    int b=95, i, r, digit, p, count=0;
    char * a, * res;// clrscr();
    p=n;
    a = malloc((size_t) 100);

    do 
    {
        r=p%b;
        digit=32+r;
        a[count]=digit;
        count++;
        p=p/b;
    } 
    while(p!=0);

    res = malloc((size_t) count);
    for(i=count-1; i>=0; --i) res[count-i-1] = a[i];

    free(a);

    return res;
}


int main(void)
{
    char* input_string;

    printf("Introduce una cadena: ");

   unsigned long long int n;
   // input_string = getstr(stdin, input_string);
    

    




    return 0;
}