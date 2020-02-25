#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

long int *code=NULL;
long int x;
long int y;
long int i=0;
long int j=0;
bool flag=true;
long int flood=0;
long int aj=0;
long int *gridw=NULL;
long int *grida=NULL;
long int *x_cordw=NULL;
long int *y_cordw=NULL;
long int *x_corda=NULL;
long int *y_corda=NULL;
long int wall=0;
long int fposx;
long int fposy;
long int ftime=0;;
bool fl=false;
char *symbols=NULL;
long int moves=0;


void backtracking(long int ** grid,long int start_x,long int start_y,char symbols[],long int x,long int y)
{
    long int i=start_x;
    long int j=start_y;
    while(grid[i][j]!=1)
    {
 if(i!=x-1)
        {

            if(grid[i+1][j]-grid[i][j]==-1)
            {
            symbols[moves]='U';
            i=i+1;
            moves++;

            continue;
            }
        }



        //left
        if(j!=0)
        {
//printf("2");
            if(grid[i][j-1]-grid[i][j]==-1)
            {
            symbols[moves]='R';
            j=j-1;
            moves++;

            continue;
            }
        }

        if(j!=y-1)
        {
//printf("4");
            if(grid[i][j+1]-grid[i][j]==-1)
            {
             symbols[moves]='L';
            j=j+1;
            moves++;

            continue;}
        }
        //up
        if(i!=0)
        {
//printf("1");
            if(grid[i-1][j]-grid[i][j]==-1)
            {
            symbols[moves]='D';

            i=i-1;
            moves++;

            continue;
            }
        }
        //right

    }
    if (moves==0)printf("stay");
}


void expandgrid(long int** grid,long int sources,long int last_added,long int x_dim[],long int y_dim[],long int xi,long int yi,long int time,bool cont)
{
   // printf("sources=%ld   total=%ld\n",sources,xi*yi-wall);
    long int sou=0;
    if (cont) return;
    else
        for(long int i=sources-1;i>=sources-last_added;i--)
    {

        //printf("im in\n");
        //printf("time=%ld\n",time);
        //printf("i=%ld\n",i);
        //printf("x_dimension=%ld  y_dimension=%ld\n",x_dim[i],y_dim[i]);
       // printf("grid=%ld\n",grid[x_dim[i]][y_dim[i]-1]);
        //up
        if(x_dim[i]!=0) {
    //printf("up\n");
                if (grid[x_dim[i]-1][y_dim[i]]==0 && grid[x_dim[i]-1][y_dim[i]]!=-1)
                    {
                        grid[x_dim[i]-1][y_dim[i]]=time;
                        sou++;
                        x_dim[sources-1+sou]=x_dim[i]-1;
                        y_dim[sources-1+sou]=y_dim[i];
                    }

        }
        //left
        if(y_dim[i]!=0)
        {

       // printf("left\n");
            if (grid[x_dim[i]][y_dim[i]-1]==0 && grid[x_dim[i]][y_dim[i]-1]!=-1)
                    {
                       // printf("pame\n");
                        grid[x_dim[i]][y_dim[i]-1]=time;
                       // printf("ok1\n");
                        sou++;
                       // printf("ok2\n");
                        x_dim[sources-1+sou]=x_dim[i];
                        //printf("ok3\n");
                        y_dim[sources-1+sou]=y_dim[i]-1;
                       // printf("index=%ld\n",index);
                    }

             //printf("im out\n");
        }
        //down
        if(x_dim[i]!=x-1)
        {
           // printf("down\n");

            if (grid[x_dim[i]+1][y_dim[i]]==0 && grid[x_dim[i]+1][y_dim[i]]!=-1)
                    {
                        grid[x_dim[i]+1][y_dim[i]]=time;
                        sou++;
                        x_dim[sources-1+sou]=x_dim[i]+1;
                        y_dim[sources-1+sou]=y_dim[i];
                    }
        }

        //right
        if(y_dim[i]!=y-1)
        {
        //printf("right\n");

            if (grid[x_dim[i]][y_dim[i]+1]==0 && grid[x_dim[i]][y_dim[i]+1]!=-1)
                    {
                       // printf("bhka");
                        grid[x_dim[i]][y_dim[i]+1]=time;
                        sou++;
                        x_dim[sources-1+sou]=x_dim[i];
                        y_dim[sources-1+sou]=y_dim[i]+1;
                    }
        }
    }
    if (sou==0)cont=true;
   /*
    for (i=0;i<sources+sou-1;i++)
    {
        printf("i = %ld\n",i);
        printf("x_dim[%ld]=%ld\n",i,x_dim[i]);
        printf("y_dim[%ld]=%ld\n",i,y_dim[i]);
    }
    */
        expandgrid(grid,sources+sou,sou,x_dim,y_dim,x,y,time+1,cont);
    }





int main(int argc, char **argv){
    FILE *file ;
    if (argc >= 2)
         file = fopen(argv[1], "r");
    else file = fopen("file.txt", "r");


    char *code;
    size_t n = 0;
    int c;

    if (file == NULL)
        return -1;

    code=malloc(sizeof(char)*1000050);
    symbols=malloc(sizeof(char)*1000050);

    while ((c = fgetc(file)) != EOF)
    {
        if (flag)
        {
            if ((char) c != '\n') y++;
            else flag = false;
        }
       if ((char) c == '\n') x++;

        code[n++] = (char) c;

    }
    code[n] = '\0';

    //x++;

   // printf("------DIMENSIONS------\n");
    //printf("x= %ld , y=%ld\n",x,y);

    long int **gridw = (long int **)malloc(x * sizeof(long int *));
    for (i=0; i<x; i++)
         gridw[i] = (long int *)malloc(y * sizeof(long int));


    long int **grida = (long int **)malloc(x * sizeof(long int *));
    for (i=0; i<x; i++)
         grida[i] = (long int *)malloc(y * sizeof(long int));

    x_cordw=malloc(sizeof(long int)*x*y);
    y_cordw=malloc(sizeof(long int)*x*y);
    x_corda=malloc(sizeof(long int)*x*y);
    y_corda=malloc(sizeof(long int)*x*y);
    i=0;
    long int xi=0;
    long int yi=0;
    while (code[i]!='\0')
    {
        if (code[i]=='.')
            {
                gridw[xi][yi]=0;
                grida[xi][yi]=0;
                yi++;
            }

        else if (code[i]=='W')
            {
                gridw[xi][yi]=1;
                grida[xi][yi]=0;

                x_cordw[flood]=xi;
                y_cordw[flood]=yi;
                yi++;
                flood++;
            }
        else if (code[i]=='A')
            {
                gridw[xi][yi]=0;
                grida[xi][yi]=1;
                x_corda[aj]=xi;
                y_corda[aj]=yi;
                yi++;
                aj++;
            }
        else if(code[i]=='X')
            {
                gridw[xi][yi]=-1;
                grida[xi][yi]=-1;
                wall++;
                yi++;
            }
        else if (code[i]=='\n')
            {
                xi++;
                yi=0;
            }
            i++;

    }

  /* printf("------FLOOD SOURCES------\n");
    for(i=0;i<flood;i++)
    {
        printf("x= %ld , y=%ld\n",x_cordw[i],y_cordw[i]);
    }

    printf("------STARTING POINT------\n");
    for(i=0;i<aj;i++)
    {
        printf("x= %ld , y=%ld\n",x_corda[i],y_corda[i]);
    }

    printf("------FLOOD GRID------\n");
    for(i=0;i<x;i++)
    {
        for(j=0;j<y;j++)
        {
             printf("%ld  ",gridw[i][j]);
        }
         printf("\n");
    }

     printf("------CAT GRID------\n");
     for(i=0;i<x;i++)
    {
        for(j=0;j<y;j++)
        {
             printf("%ld  ",grida[i][j]);
        }
     printf("\n");
    }
    printf("---------EXPAND W--------\n");*/

    expandgrid(gridw,flood,flood,x_cordw,y_cordw,x,y,2,false);

   /* for(i=0;i<x;i++)
    {
        for(j=0;j<y;j++)
        {
             printf("%ld  ",gridw[i][j]);
        }
         printf("\n");
    }

    printf("-------EXPAND A---------\n");*/
       expandgrid(grida,aj,aj,x_corda,y_corda,x,y,2,false);

    /* for(i=0;i<x;i++)
    {
        for(j=0;j<y;j++)
        {
             printf("%ld  ",grida[i][j]);
        }
         printf("\n");
    }
   printf("\n\n\n");
   printf("------------\n");*/
    for(i=0;i<x;i++)
    {
        for(j=0;j<y;j++)
        {
            if(gridw[i][j]==0 && grida[i][j]>0)
            {
                fposx=i;
                fposy=j;
                printf("infinity\n");
                fl=true;
                break;
            }

           else if ( gridw[i][j]>grida[i][j] )
           {
               if (gridw[i][j]>ftime)
               {
                    fposx=i;
                    fposy=j;
                   ftime=gridw[i][j];
               }
           }
        }
        if(fl)break;

    }
    //if(!fl) printf(" time=%ld   x=%ld    y=%ld   \n",ftime-2,fposx,fposy);
    if(!fl) printf("%ld\n",ftime-2);
    backtracking(grida,fposx,fposy,symbols,x,y);
    for(long int i=moves-1;i>=0;i--)
    {
        printf("%c",symbols[i]);
    }



    return 0;
}