#include <stdio.h>
#include <stdlib.h>

long int lenght;
long int colors;
long int *code=NULL;
long int start=0;
long int end=0;
long int *rep=NULL;
long int distinct=1;
long int min=1000001;
long int dist=0;

int main(int argc, char **argv){



    FILE *pFile ;
    if (argc >= 2)
         pFile = fopen(argv[1], "r");
    else pFile = fopen("file.txt", "r");
    fscanf(pFile,"%ld",&lenght);
    fscanf(pFile,"%ld",&colors);
    code=malloc(sizeof(long int)*lenght);
    rep=malloc(sizeof(long int)*colors);

    for(long int i=0;i<lenght;i++)
    {
        fscanf(pFile,"%ld",&code[i]);
        if (i<=colors)
            rep[i]=0;

    }
    rep[code[0]]++;
    while(start<=end && end<lenght)
    {
       if (distinct<colors) {
        end++;
        if(end<lenght){
        if(rep[code[end]]==0) {
            distinct++;
            }
        rep[code[end]]++;
       }
       }
       else if (distinct==colors)
       {
           dist=end-start;
           if (dist<min) min=dist;

           if (rep[code[start]]==1)
           {
               distinct--;
           }
          rep[code[start]]--;
          start++;
       }
//printf("START=%ld   END=%ld  DISTINCT=%ld \n",start,end,distinct);
    }

    if (min==1000001) printf("0");
    else printf("%ld",min+1);



     return 0;
}