import sys
import numpy as np
import pandas as pd


x = np.array([1,3])

print(x[0])

print(sys.argv)
day = sys.argv[1]
#[0] will take in the first argument of ENTRYPOINT in Dockerfile

print(f'Pipeline job finished for day ={day}')

