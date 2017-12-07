from math import log
import numpy as np
import matplotlib.pyplot as plt


# file = open("data.dat", "r")
file = open("train.dat", "r")
lines = file.readlines()
file.close()
# data = []
# for line in lines:
# 	line.strip()
# 	d = [x.strip() for x in line.split(',')]
# 	data.append(d)

# x is a list of lists, hence used the var t
line1 = lines[0]
lines = lines[1:len(lines)]
data = np.zeros((len(lines),55))
data = [[ float(t.strip()) for t in x] for x in [line.split(',') for line in lines]]
# data = [[ float(y) for y in t.strip() for t in x] for x in [line.split(',') for line in lines]]
# print(data)

# data's 1st row is a special one
features = [x.split(':')[0] for x in line1.split(',')]
feature_types = [x.split(':')[1] for x in line1.split(',')]

# print(features)
# print(feature_types)

# data = data[1:len(data)]
# store l = len(data) !!

# for i = range(0,len(data)):
# 	for()

# data = np.array(data)
# datt = data.T


class node:
	def __init__(self, left=None, right=None, col=-1, value=None, classes=None, ans=-1, isleaf=False, height=0,  numchild=0 , tpassed1=0, correct1=0, tmajor1=0, tpassed2=0, correct2=0, tmajor2=0, tpassed3=0, correct3=0, tmajor3=0 ):
		self.left = left 	# Left child
		self.right = right 	# Right Child
		self.col = col 		# The attribute about which I will split
		self.value = value	# The value about which data will be splitted
		self.classes = classes	# None for every column except the last one <- Changed
		self.ans = ans 			# The class i m going to assign an observations if I stop at this node
		self.isleaf = isleaf
		self.height = height

		# For the classification Part
		self.numchild = numchild  		# Total descendants of a node

		# VALIDATION
		self.tpassed1 = tpassed1 	# No. of observations reached this node while classifying
		self.correct1 = correct1 	# No. of observations correctly predicted by this SUBTREE
		self.tmajor1 = tmajor1 	# Total observations passed of majority class (ans)
		

		# TEST
		self.tpassed2 = tpassed2 	# No. of observations reached this node while classifying
		self.correct2 = correct2 	# No. of observations correctly predicted by this SUBTREE
		self.tmajor2 = tmajor2 	# Total observations passed of majority class (ans)

		# TRAIN
		self.tpassed3 = tpassed3 	# No. of observations reached this node while classifying
		self.correct3 = correct3 	# No. of observations correctly predicted by this SUBTREE
		self.tmajor3 = tmajor3 	# Total observations passed of majority class (ans)


# use 0.5 for the 0 and 1 cases
# use the mid point for continuous variables ??????
def splitdata(data, col, value):
	# data = np.array(data)
	split1 = [entry for entry in data if entry[col]<value]
	split2 = [entry for entry in data if entry[col]>=value]
	return (split1, split2)




def entropy(data):
	# data = np.array(data)
	classes = unique(data)
	ent = 0.0
	for c in classes.keys():
		prob = float(classes[c])/len(data)
		ent -= prob*log(prob)
	return ent
	
heightnums = {}

# def mix(data, split1, split2):
# 	data = np.array(data)
# 	p = float(len(split1))/len(data)
# 	return p*entropy(split1) + (1-p)*entropy(split2)


def unique(data):
	# data = np.array(data)
	classes = {}	# dictionary
	for entry in data:
		e = entry[len(entry)-1]
		if e not in classes:
			classes[e] = 0
		classes[e] += 1
	return classes	

	


def maketree(data, numnodes):
	# data = np.array(data)
	l = len(data)	
	if l==0:
		return node()
	l = len(data[0])-1
	entropy1 = entropy(data)	# Current Entropy
	opt_gain = 0.0 				# Optimal Information Gain
	opt_values = None 			# Optimal criteria (col and value)
	opt_children = None			# Optimal Split
	opt_ans = 0
	udata = unique(data)
	maxx = 0 # max value
	maxy = 0 # max class
	for key in udata:
		if udata[key] > maxx : 
			maxy = key
			maxx = udata[key] 

	opt_ans = maxy # The class i m going to assign an observations if I stop at this node		



	# data = np.array(data)
	for col in range(0,l):	# trying to split using each feature one by one
		md = 0.0
		if feature_types[col]=='Continuous' :
			ar = [e[col] for e in data]
			ar = np.array(ar)
			md = np.median(ar)
		else :
			md = 0.5	

		split1, split2 = splitdata(data, col, md)
		p = float(len(split1))/len(data)
		mi = p*entropy(split1) + (1-p)*entropy(split2)
		gain = entropy1 - mi

		if len(split1)>0 and len(split2)>0 and gain > opt_gain:
			# if(len(split1)>len(split2)) : opt_ans = 1
			# else : opt_ans = 0
			opt_gain = gain
			opt_values = (col, md)
			opt_children = (split1, split2)

	if opt_gain > 0 :
		left_subtree = maketree(opt_children[0], numnodes)
		right_subtree = maketree(opt_children[1], numnodes)
		numnodes[0] = numnodes[0] + 1
		ht = max(left_subtree.height, right_subtree.height)+1
		if ht not in heightnums:
			heightnums[ht] = 1
		else : heightnums[ht] += 1	
		return node(left=left_subtree, right=right_subtree, col=opt_values[0], value=opt_values[1], ans = opt_ans, height=ht)
	else :
		ht = 0
		numnodes[0] = numnodes[0] + 1
		if ht not in heightnums:
			heightnums[ht] = 1
		else : heightnums[ht] += 1
		return node(ans = opt_ans, isleaf = True, height=0)		

		

def levelnums(nodex, level, a):
	if level not in a :
		a[level] = 1
	else : 
		a[level] += 1
	if nodex.isleaf :
		return
	else :
		levelnums(nodex.left, level+1, a)
		levelnums(nodex.right, level+1, a)
		return	



numnodes = [0]
decision_tree = maketree(np.array(data), numnodes)

print("Heightnums are")
print(heightnums)
print("No. of nodes in the tree are")
print(numnodes[0])
print(len(data))

################################################################################
# To update the no. of descendants of every node
def update_nchild(nodex):
	if nodex.isleaf :
		nodex.numchild = 0
	else:
		update_nchild(nodex.left)
		update_nchild(nodex.right)
		nodex.numchild = nodex.left.numchild + nodex.right.numchild + 2
	return	 	

# Updating the correct count of the parent nodes of the subtree I just pruned !!
def update_parents1(nodex):
	if nodex.isleaf :
		return nodex.correct1
	else:
		w1 = update_parents1(nodex.left)
		w2 = update_parents1(nodex.right)
		nodex.correct1 = w1 + w2
		return nodex.correct1

def update_parents2(nodex):
	if nodex.isleaf :
		return nodex.correct2
	else:
		w1 = update_parents2(nodex.left)
		w2 = update_parents2(nodex.right)
		nodex.correct2 = w1 + w2
		return nodex.correct2

def update_parents3(nodex):
	if nodex.isleaf :
		return nodex.correct3
	else:
		w1 = update_parents3(nodex.left)
		w2 = update_parents3(nodex.right)
		nodex.correct3 = w1 + w2
		return nodex.correct3				


def numnodes(nodex):
	if nodex.isleaf : return 1
	else:
		return numnodes(nodex.left) + numnodes(nodex.right) + 1



#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# acc_correct records how many observations if predicted at level x will give correct answers
# acc_total records how many observations went through a particular level (as not all obs will reach the lowest level)
# Now division of the above 2 quantities will give us accuracy for a particular level
# Now will need to plot those accuracies with the no. of nodes at each level
# So once calculate the dict for above, take cumulative sums 
a = {}
levelnums(decision_tree, 0, a)
for i in range(1,32) :	# Height is 31, with height of root as 0
	a[i] += a[i-1] 

print("HERE COMES THE NO. OF NODES IN EACH LEVEL")
print(a)	

#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#___________________________________________________________________________________________________
#___________________________________________________________________________________________________
#___________________________________________________________________________________________________
def accuracyx(nodex, entry):
	if nodex.isleaf :
		return entry[len(entry)-1] == nodex.ans
	else :
		child = None		
		if entry[nodex.col]	< nodex.value : 
			child = nodex.left
		else : 
			child = nodex.right
		return accuracyx(child, entry)



def accuxy(nodex, data):
	correct = 0
	total = 0
	for entry in data :
		total += 1
		if accuracyx(nodex, entry) :
			correct += 1
	return float(correct)/total

#___________________________________________________________________________________________________


def accuracy(nodex, level, height, entry):
	if nodex.isleaf or level == height :
		return entry[len(entry)-1] == nodex.ans
	else :
		child = None		
		if entry[nodex.col]	< nodex.value : 
			child = nodex.left
		else : 
			child = nodex.right
		return accuracy(child, level+1, height, entry)	


def accux(nodex,data,height):
	correct = 0
	total = 0
	for entry in data :
		total += 1
		if accuracy(nodex, 0, height, entry) :
			correct += 1
	return float(correct)/total

#___________________________________________________________________________________________________
#___________________________________________________________________________________________________
#___________________________________________________________________________________________________

b = {}

for i in range(0,32) :
	b[i] = accux(decision_tree, data, i);







################################################################################
print("Testing on TRAINING set")
####################################################################################################
##################################    FOR TEST DATA SET     ########################################
####################################################################################################

def classifyz(entry, nodex, level, accx, total):
	boo = False
	if nodex.isleaf :
		if level not in acc_total  or level not in leaves_correct: 
			acc_correct[level] = 0
			acc_total[level] = 0

			leaves_correct[level] = 0;
			leaves_total[level] = 0;

		if entry[len(entry)-1] == nodex.ans :
			# print("LEAF Right classified bro !!, Level is ", level)
			boo = True
			acc_correct[level] += 1
			leaves_correct[level] += 1
			accx[0] += 1
			nodex.correct3 += 1

		acc_total[level] += 1	
		leaves_total[level] += 1

		total[0] += 1
		nodex.tpassed3 += 1
		return boo
	else :
		if level not in acc_total : 
			acc_correct[level] = 0
			acc_total[level] = 0
		if entry[len(entry)-1] == nodex.ans :
			# print("Right classification bro !!")
			acc_correct[level] += 1
			nodex.tmajor3 += 1
		acc_total[level] += 1	
		child = None		
		if entry[nodex.col]	< nodex.value : 
			child = nodex.left
		else : 
			child = nodex.right
		boo = classifyz(entry, child, level+1, accx, total)
		if boo : nodex.correct3 += 1
		nodex.tpassed3 += 1
		return boo


level = 0
acc_correct = {}
acc_total = {}
leaves_correct = {}
leaves_total = {}

accx = [0] # Accuracy for the leaves
total = [0]

for entry in data :
	bbb = classifyz(entry, decision_tree, 0, accx, total)


print(acc_correct)
print(acc_total)
print("---------------------------------")
print(accx)
print(total)	

print("Accuracy for training data is ", float(accx[0])/total[0])

x = acc_total.values()
y = acc_correct.values()

for i in range(0,len(y)):
	if i not in leaves_total :
		leaves_total[i] = 0
		leaves_correct[i] = 0

x1 = leaves_total.values()
y1 = leaves_correct.values()

for i in range(0,len(y)):
	y[i] += y1[i]
	x[i] += x1[i]	

for i in range(0,len(y)):
	y[i] = float(y[i])/x[i]

x = np.array(x)
y = np.array(y)
z = np.array(a.values())
zz = np.array(b.values())

# plt.plot(z, zz)







##########$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#######################
##########$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#######################
##########$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#######################
##########$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#######################

def classify(entry, nodex, level, accx, total):
	boo = False
	if nodex.isleaf :
		if level not in acc_total or level not in leaves_correct: 
			acc_correct[level] = 0
			acc_total[level] = 0
			leaves_correct[level] = 0;
			leaves_total[level] = 0;
		if entry[len(entry)-1] == nodex.ans :
			# print("LEAF Right classified bro !!, Level is ", level)
			boo = True
			acc_correct[level] += 1
			leaves_correct[level] += 1
			accx[0] += 1
			nodex.correct2 += 1
		acc_total[level] += 1
		leaves_total[level] += 1	
		total[0] += 1
		nodex.tpassed2 += 1
		return boo
	else :
		if level not in acc_total : 
			acc_correct[level] = 0
			acc_total[level] = 0
		if entry[len(entry)-1] == nodex.ans :
			# print("Right classification bro !!")
			acc_correct[level] += 1
			nodex.tmajor2 += 1
		acc_total[level] += 1	
		child = None		
		if entry[nodex.col]	< nodex.value : 
			child = nodex.left
		else : 
			child = nodex.right
		boo = classify(entry, child, level+1, accx, total)
		if boo : nodex.correct2 += 1
		nodex.tpassed2 += 1
		return boo



print("Testing on Test set")
####################################################################################################
##################################    FOR TEST DATA SET     ########################################
####################################################################################################
level = 0
acc_correct = {}
acc_total = {}
leaves_correct = {}
leaves_total = {}


# acc = np.array(acc) # Accuracies at each level
accx = [0] # Accuracy for the leaves
total = [0]

# file = open("data.dat", "r")
file = open("test.dat", "r")
lines = file.readlines()
file.close()
line1 = lines[0]
lines = lines[1:len(lines)]
data2 = [[ float(t.strip()) for t in x] for x in [line.split(',') for line in lines]]
# data = np.array(data)


c = {}

for i in range(0,32) :
	c[i] = accux(decision_tree, data2, i);

for entry in data2 :
	bb = classify(entry, decision_tree, 0, accx, total)





print(acc_correct)
print(acc_total)
print("---------------------------------")
print(accx)
print(total)	

print("Accuracy for test data is ", float(accx[0])/total[0])

x = acc_total.values()
y = acc_correct.values()

for i in range(0,len(y)):
	if i not in leaves_total :
		leaves_total[i] = 0
		leaves_correct[i] = 0

x1 = leaves_total.values()
y1 = leaves_correct.values()

for i in range(0,len(y)):
	y[i] += y1[i]
	x[i] += x1[i]

for i in range(0,len(y)):
	y[i] = float(y[i])/x[i]

x = np.array(x)
y = np.array(y)
z = np.array(a.values())
zz = np.array(c.values())

# plt.plot(z, zz)



print("Testing on Validation set")
####################################################################################################
###############################    FOR VALIDATION DATA SET     #####################################
####################################################################################################
def classifyx(entry, nodex, level, accx, total):
	boo = False
	if nodex.isleaf :
		if level not in acc_total or level not in leaves_correct: 
			acc_correct[level] = 0
			acc_total[level] = 0
			leaves_correct[level] = 0;
			leaves_total[level] = 0;
		if entry[len(entry)-1] == nodex.ans :
			boo = True
			# print("LEAF Right classified bro !!, Level is ", level)
			acc_correct[level] += 1
			leaves_correct[level] += 1
			accx[0] += 1
			nodex.correct1 += 1
		acc_total[level] += 1	
		leaves_total[level] += 1
		total[0] += 1
		nodex.tpassed1 += 1
		return boo
	else :
		if level not in acc_total : 
			acc_correct[level] = 0
			acc_total[level] = 0
		if entry[len(entry)-1] == nodex.ans :
			# print("Right classification bro !!")
			nodex.tmajor1 += 1
			acc_correct[level] += 1
		acc_total[level] += 1	
		child = None		
		if entry[nodex.col]	< nodex.value : 
			child = nodex.left
		else : 
			child = nodex.right
		nodex.tpassed1 += 1	
		boo = classifyx(entry, child, level+1, accx, total)
		if boo : nodex.correct1 += 1
		return boo






level = 0
acc_correct = {}
acc_total = {}
leaves_correct = {}
leaves_total = {}
# acc = np.array(acc) # Accuracies at each level
accx = [0] # Accuracy for the leaves
total = [0]

# file = open("data.dat", "r")
file = open("valid.dat", "r")
lines = file.readlines()
file.close()
line1 = lines[0]
lines = lines[1:len(lines)]
data3 = [[ float(t.strip()) for t in x] for x in [line.split(',') for line in lines]]
# data = np.array(data)

d = {}

for i in range(0,32) :
	d[i] = accux(decision_tree, data3, i);



for entry in data3 :
	bb = classifyx(entry, decision_tree, 0, accx, total)



# if decision_tree.correct == decision_tree.left.correct + decision_tree.right.correct :
# 	print("SAHI HAI BHAI !!~~~~~~~~~~~~~~~~")
# else:
# 	print("SAHI NAHI HAI !!~~~~~~~~~~~~~~~~")	

print(acc_correct)
print(acc_total)
print("---------------------------------")
print(accx)
print(total)	

x = acc_total.values()
y = acc_correct.values()

for i in range(0,len(y)):
	if i not in leaves_total :
		leaves_total[i] = 0
		leaves_correct[i] = 0

x1 = leaves_total.values()
y1 = leaves_correct.values()

for i in range(0,len(y)):
	y[i] += y1[i]
	x[i] += x1[i]

for i in range(0,len(y)):
	y[i] = float(y[i])/x[i]

x = np.array(x)
y = np.array(y)
z = np.array(a.values())
zz = np.array(d.values())

# plt.plot(z, zz)




# plt.savefig('Q1_a')
# plt.xlabel('No. of nodes')
# plt.ylabel('Accuracy')
# plt.title('Q1 :Accuracies')
# plt.legend(['Training', 'Validation', 'Testing'])
# plt.show()


### THE X AXIS VALUES IN THE GRAPH ARE INCORRECT
### MAKE A FUNC TO CALCULATE NO OF NODES AT A PARTICULAR HEIGHT
### THE HEIGHT WAS CALCULATED WHILE THE TREE WAS MADE, ITS = decision_tree.height

accv = float(accx[0])/total[0]
print("Accuracy on validation set is ", accv)
#################################### PRUNING !!!
### IN PRUNING THE 3 GRAPHS ARE REQUIRED AGAIN !!!
### THE SPECIAL TPASSED AND CORRECT FIELDS MAY BE REQUIRED FOR THE TRAINING AS WELL AS TEST DATA
### AND THEN WIL ALSO NEED TO KNOW HOW MANY NODES WERE PRUNED WHILE PRUNING A SUBTREE
### SO KEEP A COUNT OF TOTAL NODES IN A SUBTREE FOR ALL THE NODES, CAN DO THIS IN ONE TRAVERSAL

# let prune func returns the node which gives max increase in accv ?
# have to make that node = NULL which gave the max increase
# ALSO MAKE ISLEAF = TRUE FOR THE NODE BEING PRUNED
# tempcorrect = yo[0] - nodex.correct + nodex.tmajor - (nodex.tpassed - nodex.tmajor)

# def prune(nodex, yo, bo) >>> ??
def prune(nodex, bestnode):
	if nodex.isleaf :
		return 
	else :
		tempcorrect = yo[0] - nodex.correct1 + nodex.tmajor1
		if tempcorrect > yo[0]:
			bestnode[0] = nodex
			# print("GOT ONE !!!!!!")
			yo[0] = tempcorrect
			bo[0] = True
		prune(nodex.left, bestnode)
		prune(nodex.right, bestnode)
		return
	

update_nchild(decision_tree)

bo = [False] 				# Whether we got a better accuracy in this dfs or not 
bestnode = [None]
bestcorrect = accx[0]
bestacc = accv
yo = [bestcorrect, total] 	# [ total correctly classified obs, total obs, accx/total ]
pruned = [0]

mygarph1 = {}
mygarph2 = {}
mygarph3 = {}


while True :
	bo[0] = False
	prune(decision_tree, bestnode)
	if not bo[0]: 
		break
	else:
		# print("A NODE IS GOING TO BE PRUNED")
		bestnode[0].isleaf = True
		bestnode[0].left = None
		bestnode[0].right = None
		bestnode[0].correct1 = bestnode[0].tmajor1
		bestnode[0].correct2 = bestnode[0].tmajor2
		bestnode[0].correct3 = bestnode[0].tmajor3
		x = update_parents1(decision_tree)
		y = update_parents2(decision_tree)
		#///////////////////////////////////////////////
		z = update_parents3(decision_tree)
		n = numnodes(decision_tree)
		# mygarph1[n] = x
		# mygarph2[n] = y
		#///////////////////////////////////////////////
		# mygarph3[n] = z
		# print("x is ", x)
		# print("yo is ", yo[0])
		# if x == yo[0]: print("ITS EQUALL !!")
		# else: print("ITS NOT EQUALL !!") 
		pruned[0] += bestnode[0].numchild
		print("No. of nodes pruned ", pruned[0])
		print("No. of nodes in tree ", n)
		update_nchild(decision_tree)

		# mygarph1[n] = accuxy(decision_tree, data3)
		# mygarph2[n] = accuxy(decision_tree, data2)
		# mygarph3[n] = accuxy(decision_tree, data)






print("AFTER PRUNING !!!")
print(yo[0])
print(total[0])
x = update_parents1(decision_tree)
y = update_parents2(decision_tree)
z = update_parents3(decision_tree)

print("Total no. of pruned nodes ", pruned[0])
nn = numnodes(decision_tree)
print("Total no. of nodes left in tree are ", nn)
# print("Accuracy on validation set is ", float(mygarph1[nn])/total[0])
# print("Accuracy on test data set is ", float(mygarph2[nn])/total[0])
# print("Accuracy on train data set is ", float(mygarph3[nn])/total[0])






# x1 = np.array(mygarph1.keys())
# y1 = np.array(mygarph1.values())
# # for i in range(0,len(y1)):
# # 	y1[i] = float(y1[i])/total[0]

# plt.plot(x1, y1)



# x2 = np.array(mygarph2.keys())
# y2 = np.array(mygarph2.values())
# # for i in range(0,len(y1)):
# # 	y1[i] = float(y1[i])/total[0]

# plt.plot(x2, y2)


# x3 = np.array(mygarph3.keys())
# y3 = np.array(mygarph3.values())
# # for i in range(0,len(y1)):
# # 	y1[i] = float(y1[i])/total[0]

# plt.plot(x3, y3)

# plt.savefig('Q1_b')
# plt.xlabel('No. of nodes')
# plt.ylabel('Accuracy')
# plt.title('Q1 : PRUNING')
# plt.legend(['Validation', 'Testing', 'Training'])

# plt.show()








