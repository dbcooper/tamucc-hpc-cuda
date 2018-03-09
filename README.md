Simple CUDA code samples and Slurm files to run them on TAMUCC HPC

All code adapted from TAMU Introduction to CUDA Programming HPRC short course by Jian Tao <jtao@tamu.edu>

https://hprc.tamu.edu/training/intro_cuda.html

I'm assuming you already have access to TAMUCC HPC  http://hpc.tamucc.edu/

Once you've logged in, you'll need to load (at least) two modules:

    module load cuda80/toolkit
    module load slurm

Once you've done that you should be able to compile all the code using `make`:

    make

If it's working correctly, you'll see something like the following:

    nvcc -arch=sm_30 -o hello hello.cu
    nvcc -arch=sm_30 -o hello_dc/hello_dc hello_dc/hello_dc.cu
    nvcc -arch=sm_30 -o vectoradd/vectoradd vectoradd/vectoradd.cu
    nvcc -arch=sm_30 -o vectoradd_par/vectoradd_par vectoradd_par/vectoradd_par.cu

Run the first (non-GPU/CUDA) program:

    ./hello

If it works, you'll see this printed on your console:

    Hello, world!

To run a CUDA-enabled program on a node w/ a GPU:

    cd vectoradd
    sbatch vectoradd.slurm

If everything works correctly, the output of the program will be in the file `vectoradd.out`.  To view the output:

    cat vectoradd.out

