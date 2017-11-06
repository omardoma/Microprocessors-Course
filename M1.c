#include <stdio.h>

int avgElement(int, int *, int[], int[]);
void avgSignal(int[], int[]);

int avgElement(int midIndex, int *j, int signal[], int kernel[])
{
    int sum = 0;
    int i;
    for (i = *j; i < 7 && i < 10 - midIndex; i++)
    {
        if (midIndex < 0)
        {
            (*j)++;
        }
        sum += signal[i];
    }

    return (sum / ((i - *j) + 1));
}

void avgSignal(int signal[], int kernel[])
{
    int midIndex = (10 / 2) - 1;
    int j = 0;
    for (int i = 0; i < 10; i++)
    {
        signal[i] = avgElement(midIndex, &j, signal, kernel);
        midIndex--;
    }
}

int main()
{
    int signal[7] = {1, 2, 3, 4, 5, 6, 7};
    int kernel[10] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};
    avgSignal(signal, kernel);
    for (int i = 0; i < 7; i++)
    {
        printf("%d", signal[i]);
        printf("%s", " ");
    }
    return 0;
}