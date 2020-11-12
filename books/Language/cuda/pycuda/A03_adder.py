# -*- coding: utf-8 -*-

from numpy.core.defchararray import add
from numpy.core.shape_base import block
import pycuda.autoinit
import pycuda.driver as drv
import numpy as np
from pycuda.compiler import SourceModule

mod = SourceModule(
    """
    __global__ void add_num(float *r, float *a, float *b){
        int tid = threadIdx.x;
        r[tid] = a[tid] + b[tid];
    }
"""
)

add_num = mod.get_function("add_num")

h_a = np.array([1.5], dtype=np.float32)
h_b = np.array([2.5], dtype=np.float32)

h_result = np.empty((1,), dtype=np.float32)

print(h_a, h_b, h_result)

d_a = drv.mem_alloc(h_a.nbytes)
d_b = drv.mem_alloc(h_b.nbytes)
d_result = drv.mem_alloc(h_result.nbytes)

drv.memcpy_htod(d_a, h_a)
drv.memcpy_htod(d_b, h_b)

add_num(d_result, d_a, d_b, block=(1, 1, 1), grid=(1, 1))

drv.memcpy_dtoh(h_result, d_result)

print(f"{h_a}+{h_b}={h_result}")
