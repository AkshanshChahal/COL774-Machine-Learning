from numpy import array, loadtxt
from sklearn import svm
from sklearn.model_selection import cross_val_score

# with open('attr.txt') as fin:
#     x = loadtxt(fin)

fin = open('attr.txt')
x = loadtxt(fin)

fin = open('label.txt')
y = loadtxt(fin)    

# with open('label.txt') as fin:
#     y = loadtxt(fin)

clf = svm.SVC(decision_function_shape='ovo')
scores = cross_val_score(clf, x, y, cv=10)
print(scores)