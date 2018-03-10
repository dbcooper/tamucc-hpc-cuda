#include <stdio.h>

__global__ void VecAdd(int* ret, int a, int b)
{
        ret[threadIdx.x] = a + b + threadIdx.x;
}

int main(void)
{
        int  a   = 10;
        int  b   = 100;
        int* ret = NULL;                // results of addition

        cudaMallocManaged(&ret, 1000 * sizeof(int));
        VecAdd<<< 1, 1000 >>>(ret, a, b);
        cudaDeviceSynchronize();
        for (int i = 0; i < 1000; i++) {
                printf("%4d: %d + %d + %4d = %5d\n", i, a, b, i, ret[i]);
        }
        cudaFree(ret);
        return 0;
}
