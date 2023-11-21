"""
Stat/CS 5525: Homework 1
Author:      Kazi Hasan Ibn Arif
Student ID:  906614469
Email:       hasanarif@vt.edu
Date:        Sep 10, 2023
"""

import numpy as np


def euclidean_distance(x1,x2):
    """
        Euclidean distance between two vectors
        x1: first vector
        x2: second vector
    """
    return np.sqrt(np.sum((x1-x2)**2))


def knn_classifer(
        new: np.ndarray,
        X: np.ndarray,
        y: np.ndarray,
        k: int
):
    """
    KNN classifier
        new: new data points
        X: training data
        y: training labels
        k: number of nearest neighbors

    returns: predicted labels for new data points
    """
    new_labels = np.array([])
    for new_point in new:
        distances = np.array([euclidean_distance(new_point, x) for x in X])
        indices = np.argsort(distances)[:k]
        labels = y[indices]
        new_labels = np.append(new_labels, np.argmax(np.bincount(labels)))
    return new_labels        




