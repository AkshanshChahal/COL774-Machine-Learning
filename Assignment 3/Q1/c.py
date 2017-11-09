from sklearn import tree
import numpy as np

file = open("train.dat", "r")
# file = open("data.dat", "r")
lines = file.readlines()
file.close()

line1 = lines[0]
lines = lines[1:len(lines)]
data = [[ int(t.strip()) for t in x] for x in [line.split(',') for line in lines]]

train_labels = [entry[-1] for entry in data]
train_data = [entry[:-1] for entry in data]

# print(train_data)
# print(train_labels)

file = open("test.dat", "r")
# file = open("data.dat", "r")
lines = file.readlines()
file.close()

line1 = lines[0]
lines = lines[1:len(lines)]
data = [[ int(t.strip()) for t in x] for x in [line.split(',') for line in lines]]

test_labels = [entry[-1] for entry in data]
test_data = [entry[:-1] for entry in data]

# print(train_data)
# print(train_labels)

file = open("valid.dat", "r")
# file = open("data.dat", "r")
lines = file.readlines()
file.close()

line1 = lines[0]
lines = lines[1:len(lines)]
data = [[ int(t.strip()) for t in x] for x in [line.split(',') for line in lines]]

valid_labels = [entry[-1] for entry in data]
valid_data = [entry[:-1] for entry in data]

# print(train_data)
# print(train_labels)

for depth in [None] + range(29, 32):
	for min_leaf in range(1, 4):
		for min_split in range(2, 5):
			mytree = tree.DecisionTreeClassifier(max_depth=depth, min_samples_leaf=min_leaf, min_samples_split=min_split)
			model = mytree.fit(train_data, train_labels)

			train_score = 100*model.score(train_data, train_labels)
			test_score  = 100*model.score(test_data, test_labels)
			valid_score = 100*model.score(valid_data, valid_labels)

			print('{}\t{}\t{}\t{}\t{}\t{}'.format(depth, min_leaf, min_split, train_score, test_score, valid_score))











