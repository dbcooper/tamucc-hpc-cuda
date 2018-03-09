#include <stdio.h>

__global__ void add(int* a, int* b, int* c)
{
        *c = *a + *b;
}

int main(void)
{
        int a, b, c;                    // host copies of data
        int *d_a, *d_b, *d_c;           // devices coipes of data
        int size = sizeof(int);

        printf("Integer size is %d bytes\n", size);

        // Allocate space for device copies of data
        cudaMalloc((void**) &d_a, size);
        cudaMalloc((void**) &d_b, size);
        cudaMalloc((void**) &d_c, size);

        // Setup integers
        a = 2;
        b = 7;

        printf("a=%d;  b=%d\n", a, b);

        // Copy inputs to device
        cudaMemcpy(d_a, &a, size, cudaMemcpyHostToDevice);
        cudaMemcpy(d_b, &b, size, cudaMemcpyHostToDevice);

        // Launch add() on device
        add<<<1,1>>>(d_a, d_b, d_c);

        // Copy result to host
        cudaMemcpy(&c, d_c, size, cudaMemcpyDeviceToHost);

        // Cleanup
        cudaFree(d_a);
        cudaFree(d_b);
        cudaFree(d_c);

        // Print out results
        printf("a + b = c\n");
        printf("%d + %d = %d\n", a, b, c);

        return 0;
}
