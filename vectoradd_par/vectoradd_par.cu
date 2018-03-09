#include <stdio.h>
#include <stdlib.h>

__global__ void add(int* a, int* b, int* c)
{
        c[blockIdx.x] = a[blockIdx.x] + b[blockIdx.x];
}

// Put count random integers into integer [array] pointed to by p
void random_ints(int *p, int count)
{
        for (int i=0; i < count; i++) {
                p[i] = rand() % 32768;  // limit random numbers to [0, 32768]
        }
}

#define N 512

int main(void)
{
        int *a, *b, *c;                 // host copies of data
        int *d_a, *d_b, *d_c;           // devices copies of data
        int size = N * sizeof(int);     // Number of bytes for N integers

        printf("Total integer space size is %d bytes\n", size);

        // Allocate space for device copies of data
        cudaMalloc((void**) &d_a, size);
        cudaMalloc((void**) &d_b, size);
        cudaMalloc((void**) &d_c, size);

        // Allocate space for host copies of input values (a, b, c arrays)
        a = (int *)malloc(size);
        b = (int *)malloc(size);
        c = (int *)malloc(size);

        // Setup integers
        random_ints(a, N);
        random_ints(b, N);

        // Copy inputs to device
        cudaMemcpy(d_a, a, size, cudaMemcpyHostToDevice);
        cudaMemcpy(d_b, b, size, cudaMemcpyHostToDevice);

        // Launch add() on device
        add<<<N,1>>>(d_a, d_b, d_c);

        // Copy result to host
        cudaMemcpy(c, d_c, size, cudaMemcpyDeviceToHost);

        // Print out results
        printf("\nResults of parallel GPU addition across %d elements:\n", N);
        for (int i=0; i < N; i++) {
                int sum = a[i] + b[i];
                if (c[i] == sum) {
                        printf("%4d: %6d + %6d = %6d\n", i, a[i], b[i], c[i]);
                }
                else {
                        printf("%4d: %6d + %6d != %6d  ERROR, should be %d", i, a[i], b[i], c[i], sum);
                }
        }

        // Cleanup
        free(a);  free(b);  free(c);
        cudaFree(d_a);
        cudaFree(d_b);
        cudaFree(d_c);

        return 0;
}
