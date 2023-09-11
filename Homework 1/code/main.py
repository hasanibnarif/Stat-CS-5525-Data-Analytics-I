import matplotlib.pyplot as plt
import numpy as np
from knn import knn_classifer

train = np.loadtxt('training.txt', delimiter=',')
training_points = train[:, :2]
training_labels = train[:, 2].astype(int)
test_points = np.loadtxt('test.txt', delimiter=',')

for k in [5,10,15]:
    test_labels = knn_classifer(test_points, training_points, training_labels, k)
    plt.scatter(test_points[:, 0], test_points[:, 1], c=test_labels, cmap='bwr', marker='+')
    plt.title(f'knn classification with k = {k}')
    plt.savefig(f'knn classification with k = {k}.png')
    plt.show()