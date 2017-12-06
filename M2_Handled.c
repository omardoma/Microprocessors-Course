#include <xmmintrin.h> //Header for intrinsic functions
#include <stdio.h>
#include <time.h>

int main()
{
    // Variables definition and initialization
    int MAX_DIM = 100;
    float a[MAX_DIM][MAX_DIM] __attribute__((aligned(16)));
    float b[MAX_DIM][MAX_DIM] __attribute__((aligned(16)));
    float c[MAX_DIM][MAX_DIM] __attribute__((aligned(16)));
    float d[MAX_DIM][MAX_DIM] __attribute__((aligned(16)));
    for (int i = 0; i < MAX_DIM; ++i)
    {
        for (int j = 0; j < MAX_DIM; ++j)
        {
            a[i][j] = 1; // Arbitrary initializations - Replace to test your multiplication
            b[i][j] = 2; // Arbitrary initializations - Replace to test your multiplication
            c[i][j] = 0; // Necessary Initialization - Don't change
            d[i][j] = 0; // Necessary Initialization - Don't change
        }
    }
    // Unoptimized Matrix Multiplication
    clock_t Time1 = clock();
    for (int i = 0; i < MAX_DIM; ++i)
    {
        for (int j = 0; j < MAX_DIM; ++j)
        {
            for (int k = 0; k < MAX_DIM; k++)
            {
                c[i][j] += a[i][k] * b[k][j];
            }
        }
    }
    clock_t Time2 = clock();
    clock_t Time3 = clock();
    // YOUR CODE HERE

    int i, count = 0;
    while (i < MAX_DIM)
    {
        int sum = 0;
        int MAX = MAX_DIM;
        for (int j = 0; j < MAX_DIM; j += 4)
        {
            float lafResult[] = {0.0f, 0.0f, 0.0f, 0.0f};
            __m128 lvfA;
            __m128 lvfB;
            if (MAX >= 4)
            {
                lvfA = _mm_set_ps(a[i][j], a[i][j + 1], a[i][j + 2], a[i][j + 3]);
                lvfB = _mm_set_ps(b[j][i], b[j + 1][i], b[j + 2][i], b[j + 3][i]);
            }
            else
            {
                switch (MAX)
                {
                case 1:
                    lvfA = _mm_set_ps(a[i][j], 0, 0, 0);
                    lvfB = _mm_set_ps(b[j][i], 0, 0, 0);
                    break;
                case 2:
                    lvfA = _mm_set_ps(a[i][j], a[i][j + 1], 0, 0);
                    lvfB = _mm_set_ps(b[j][i], b[j + 1][i], 0, 0);
                    break;
                case 3:
                    lvfA = _mm_set_ps(a[i][j], a[i][j + 1], a[i][j + 2], 0);
                    lvfB = _mm_set_ps(b[j][i], b[j + 1][i], b[j + 2][i], 0);
                    break;
                }
            }
            __m128 lvfA_mul_B = _mm_mul_ps(lvfA, lvfB);
            _mm_store_ps(lafResult, lvfA_mul_B);
            sum += lafResult[0] + lafResult[1] + lafResult[2] + lafResult[3];
            MAX -= 4;
        }
        d[i][count] = sum;
        if (++count == MAX_DIM)
        {
            count = 0;
            i++;
        }
    }

    clock_t Time4 = clock();
    // Calculate and print execution times
    double TotalTimeLoop = ((double)Time2 - (double)Time1) / CLOCKS_PER_SEC;
    double TotalTimeSIMD = ((double)Time4 - (double)Time3) / CLOCKS_PER_SEC;
    printf(" Time taken by loop is %.7f \n", TotalTimeLoop);
    printf(" Time taken by SIMD optimized code is %.7f \n", TotalTimeSIMD);

    for (int i = 0; i < MAX_DIM; i++)
    {
        for (int j = 0; j < MAX_DIM; j++)
        {
            printf("[%.2f]", c[i][j]);
        }
        printf("\n");
    }
    printf("\n");
    printf("\n");

    for (int i = 0; i < MAX_DIM; i++)
    {
        for (int j = 0; j < MAX_DIM; j++)
        {
            printf("[%.2f]", d[i][j]);
        }
        printf("\n");
    }
    return 0;
}