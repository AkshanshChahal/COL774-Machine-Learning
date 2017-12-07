from sklearn.ensemble import RandomForestClassifier

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






for n_estimator in range(8,15,2):
	for boot in [True, False]:
		for feature in [None,'auto','sqrt']:

			forest = RandomForestClassifier(n_estimators=n_estimator,max_features=feature,bootstrap=boot)

			model = forest.fit(train_data, train_labels)

			train_score = 100*model.score(train_data, train_labels)
			test_score  = 100*model.score(test_data, test_labels)
			valid_score = 100*model.score(valid_data, valid_labels)

			print('{}\t{}\t{}\t{}\t{}\t{}'.format(n_estimator, feature, boot, train_score, test_score, valid_score))









