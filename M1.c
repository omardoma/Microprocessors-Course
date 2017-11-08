#include <stdio.h>
#include <stdlib.h>

int avgElement(int, int *);
int *avgSignal(int *, int *);

int kernelLength;
int signalLength;

int avgElement(int midIndex, int *signal)
{
    int sum = 0;
    int intersectionIndex=-1;
    if(midIndex < 0){
        intersectionIndex=-1* midIndex ;
    }
    else{
        intersectionIndex=0;        
    }
    int i = intersectionIndex;
    while (i < signalLength && i < (kernelLength - midIndex))
    {
        sum += signal[i];
        i++;
    }
    return (sum / (i - intersectionIndex));
}

int *avgSignal(int *signal, int *kernel)
{
    int midIndex = (kernelLength / 2) - 1;
    int *result = malloc(signalLength * sizeof(int));
    int i = 0;
    while (i < signalLength)
    {
        result[i] = avgElement(midIndex--, signal);
        i++;
    }
    return result;
}

int main()
{
    int signal[7];
    signal[0]=1;
    signal[1]=2;
    signal[2]=3;
    signal[3]=4;
    signal[4]=5;
    signal[5]=6;
    signal[6]=7;

    int kernel[10];
    kernel[0]=1;
    kernel[1]=1; 
    kernel[2]=1;
    kernel[3]=1;
    kernel[4]=1; 
    kernel[5]=1; 
    kernel[6]=1;
    kernel[7]=1;
    kernel[8]=1;
    kernel[9]=1;

    kernelLength = sizeof(kernel) / sizeof(int);
    signalLength = sizeof(signal) / sizeof(int);
    int *result = avgSignal(signal, kernel);
    int i = 0;
    printf("\nAverage Signal: ");
    while (i < signalLength)
    {
        printf("%d ", result[i]);
        i++;
    }
     return 0;
}