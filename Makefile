all: hello hello_dc/hello_dc vectoradd/vectoradd vectoradd_par/vectoradd_par vectoradd_unified/vectoradd_unified

# General rule on compiling CUDA code
% :: %.cu
	nvcc -arch=sm_30 -o $@ $<

clean:
	find ./ -name '*.o' -o -name '*.out' -o -name '*.err' | xargs -r rm
	rm hello
	rm hello_dc/hello_dc
	rm vectoradd/vectoradd
	rm vectoradd_par/vectoradd_par
	rm vectoradd_unified/vectoradd_unified

