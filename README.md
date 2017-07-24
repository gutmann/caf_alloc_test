# Test allocation timing for Coarray Fortran
Coarray Fortran using gfortran and opencoarrays can take a long time to allocate coarrays on large numbers of nodes.  This repository serves as a test case for timing allocations.  In particular, one simulation to test the scaling characteristics of an [experimental coarray version](https://github.com/gutmann/coarray_icar) of [ICAR](https://github.com/NCAR/icar) on nearly 10,000 cores was unable to even finish initializing the model after 10 hours.  Previous timing tests had indicated that allocating the arrays took longer on more nodes, so this test case was developed to understand the problem.

## Compile:
make

## Run:
cafrun ./alloc_test

## Results:
Tests were performed on NCAR's [Cheyenne](https://www2.cisl.ucar.edu/resources/computational-systems/cheyenne) supercomputer.  Compilation was performed using gfortran v6.3 and opencoarrays v1.8.2.  The MPI library is MPT/2.15, supplied by the vendor (SGI).  While the allocations in this test do not take as long as the allocations in the [coarray icar](https://github.com/gutmann/coarray_icar) code, they illustrate the scaling problem.  In particular, allocations take longer depending on the number of coarray images (i.e. cores/processes) used (see [table 1](#Table-1.-timing-tests)), and each successive allocation in a run takes longer (see [Sample Output](#Sample-output)).  Not shown here, the total runtime of this code is also long on many cores.  The finalization time between the last allocation and the end of the program is often ~2-3 minutes on 50 nodes, this also scales with the number of nodes.

|  N_images  | Max alloc time  | Nodes |
| ----------:| ---------------:|------:|
|         36 |          0.01 s |      1|
|         72 |          0.09 s |      2|
|        360 |          1.32 s |     10|
|       1800 |          18.1 s |     50|
|       9216 |        ~1800* s |    256|

#### Table 1. timing tests
Note that with 256 nodes the test did not complete in 1 hour.  The first allocation took 365 s, later allocations typically take 5x longer than the first allocation, so 1800 s (1/2 hr) is a crude estimate. 

## Sample output
```
> time cafrun ./test
         360
  0.180000007    
  0.204000056    
  0.419999957    
  0.552000046    
  0.384000063    
  0.323999882    
  0.368000031    
  0.667999983    
   1.31600022    

real	0m22.464s
user	0m0.008s
sys	0m0.100s
```

## Description
This test case prints the number of images being used, then prints the time (cpu_time) needed to allocate a sequence of 9 coarrays in a derived type.  There are 9 instances of this derived time and the code sequentially prints the timing of an allocation subroutine for each of the 9 instances.  
