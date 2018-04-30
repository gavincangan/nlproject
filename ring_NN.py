from collections import deque
import random
import matplotlib.pyplot as plt
import numpy as np

iter_count = 1000

N = 1000
dim = 5
k = 5
g = 1

min_g = 0
max_g = 5
g_steps = 2

num_g_steps = ( (max_g - min_g) / g_steps ) + 1

g_array = np.linspace(min_g, max_g, num_g_steps)

J = np.random.rand(N, k, dim)
J = 2 * J - 1

S = np.random.rand(N, dim)
S = 2 * S - 1

for g in range(min_g, max_g):
    sigma = []
    for itercount in range(iter_count):
        old_S = S.copy()
        for i in range(N):
            # nbors = ( S[(i-2)%N], S[(i-1)%N], S[i] S[(i+1)%N], S[(i+2)%N )
            nbor_sum = np.zeros((dim))
            for nbor_indx in range(-2, 3):
                # print np.shape( J[ i, 2 + nbor_indx, : ] )
                # print np.shape( S[ (i + nbor_indx + N)%N, : ] )
                nbor_sum += np.multiply( S[ (i + nbor_indx + N)%N, : ],  J[ i, 2 + nbor_indx, : ] )
            S[i, :] = np.tanh( nbor_sum * g )

        sigma.append( np.sum( np.square(old_S - S) / N ) )
        # if(itercount % 5 == 0):
        #     print sigma

    x = np.asarray(range(iter_count))
    y = np.asarray(sigma)

    plt.plot( x, y, label='g='+str(g) )

plt.xlabel('x label')
plt.ylabel('y label')

plt.title("Simple Plot")

plt.legend()

plt.show()