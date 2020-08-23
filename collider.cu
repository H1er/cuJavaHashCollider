#include <stdio.h>
#include <stdlib.h>
#include <string.h>


char * getstr(FILE* f, char * str)
{
    char l = 'A';
    size_t size = 20;
    int pos = 0;
    str = (char*) malloc(size);
    
    while(l != '\0' && l != '\n')
    {
        scanf("%c", &l);

        str[pos] = l;
        pos++;

         if(pos > size)
        {
            str = (char*) realloc(str, size*2);
        }
    }

    fflush(stdin);
    
    return (char *)realloc(str, pos);
}

__device__ __host__  int shc(char* ca) 
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

__device__ char * id2str(unsigned long long int n) 
{
    //Convert the id of the thread into the string in order to be checked
    int b=95, i, r, digit, p, count=0;
    char * a, * res;// clrscr();
    p=n;
 
    a = (char*) malloc(100); //cudaMallocManaged(&a, 100);

    do 
    {
        r=p%b;
        digit=32+r;
        a[count]=digit;
        count++;
        p=p/b;
    } 
    while(p!=0);

    res = (char*) malloc(count+1);

    for(i=count-1; i>=0; --i) res[count-i-1] = a[i];

    res[count] = '\n';

    free(a);

    return res;
}

__global__ void findcollisions(int hash, int f)
{
    unsigned long long int id = (unsigned long long int) blockDim.x * (unsigned long long int) blockIdx.x + (unsigned long long int) threadIdx.x; //+ i* /*4e40*/;

    if(id % 1000000000 == 0)
    {
        printf("\nid = %d\n", id);
    }
    
    char *trystr = id2str(id);
    int hc=0;

    hc = shc(trystr);

    
    if(hc == hash)
    {
        printf("Collision found with hashcode %d for string  ┤%s├\n", hc, trystr);
    }
    else
    {
        int tam = 0;
        

        while(trystr[tam]!='\0')
            tam++;

        char c = '!';
        int n=0;

        for(int i=0;i<tam-1;i++)
        {
            if(c != trystr[i])
            {
                n = 1;
            }

        }

        if(n == 0 && tam >2)
        {
            printf("Tam = %d\n", tam-1);
        }

        if(trystr[tam-1] == ' ')
        {
            char * reverse;
            reverse = (char *) malloc(tam);

            for(int i=tam-1; i>=0; --i) reverse[tam-i-1] = trystr[i];

            hc = shc(reverse);
            
            if(hc == hash)
                printf("Collision found with hashcode %d for string ┤%s├", hc, trystr);
            
    
            free(reverse);
        }
    }
    free(trystr);
}


int main(void)
{
    char* input_string= NULL;

    printf("Introduce una cadena: ");

   
    input_string = getstr(stdin, input_string);
    int hash = shc(input_string);
    
    printf("hashcode: %d\n\n", hash);

    findcollisions<<<1073741824,1024>>>(hash, 0); //<<<2^23, 2^10>>>

   
    cudaDeviceSynchronize();
    
    free(input_string);

    return 0;
}