#include <stdio.h>
#include <stdlib.h>

int avgElement(int, int *);
int *avgSignal(int *, int *);

int kernelLength;
int signalLength;

int avgElement(int midIndex, int *signal)
{
    int sum = 0;
    int intersectionIndex = midIndex < 0 ? -1 * midIndex : 0;
    int i;
    for (i = intersectionIndex; i < signalLength && i < (kernelLength - midIndex); i++)
    {
        sum += signal[i];
    }
    return (sum / (i - intersectionIndex));
}

int *avgSignal(int *signal, int *kernel)
{
    int midIndex = (kernelLength / 2) - 1;
    int *result = malloc(signalLength * sizeof(int));
    for (int i = 0; i < signalLength; i++)
    {
        result[i] = avgElement(midIndex--, signal);
    }
    return result;
}

int main()
{
    int signal[] = {1, 2, 3, 4, 5, 6, 7};
    int kernel[] = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1};
    kernelLength = sizeof(kernel) / sizeof(int);
    signalLength = sizeof(signal) / sizeof(int);
    int *result = avgSignal(signal, kernel);
    printf("Average Signal: ");
    for (int i = 0; i < signalLength; i++)
    {
        printf("%d ", result[i]);
    }
    return 0;
}