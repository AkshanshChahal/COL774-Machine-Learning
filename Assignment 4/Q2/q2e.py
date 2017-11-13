from numpy import array, loadtxt
from sklearn import svm
from sklearn.model_selection import cross_val_score


fin = open('imagex1.txt')
x1 = loadtxt(fin)

fin = open('imagey1.txt')
y1 = loadtxt(fin)

fin = open('imagex2.txt')
x2 = loadtxt(fin)

fin = open('imagey2.txt')
y2 = loadtxt(fin)


clf = svm.SVC(decision_function_shape='ovo')
scores = cross_val_score(clf, x1, y1, cv=10)
print(scores)


clf = svm.SVC(decision_function_shape='ovo')
scores = cross_val_score(clf, x2, y2, cv=10)
print(scores)


fin = open('proj1.txt')
p1 = loadtxt(fin)

fin = open('proj2.txt')
p2 = loadtxt(fin)


clf = svm.SVC(decision_function_shape='ovo')
scores = cross_val_score(clf, p1, y1, cv=10)
print(scores)


clf = svm.SVC(decision_function_shape='ovo')
scores = cross_val_score(clf, p2, y2, cv=10)
print(scores)
