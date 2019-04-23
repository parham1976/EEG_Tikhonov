import numpy as np
import numpy
import pandas
from keras.models import Sequential
from keras.layers import Dense
from keras.wrappers.scikit_learn import KerasRegressor
from sklearn.model_selection import cross_val_score
from sklearn.model_selection import KFold
from sklearn.preprocessing import StandardScaler
from sklearn.pipeline import Pipeline
##
# load dataset

# load dataset
dataframe = pandas.read_csv("training_data.csv", sep=',', header=None)
dataset = dataframe.values
# split into input (X) and output (Y) variables

X_train = dataset[:,0:3];
Y_train = dataset[:,3];
del dataset;
del dataframe;

dataframe = pandas.read_csv("test_data.csv", sep=',', header=None)
dataset = dataframe.values
X_test = dataset[:,0:3];
Y_test = dataset[:,3];
del dataframe;
del dataset;

# define base model
def baseline_model():
	# create model
	model = Sequential()
	model.add(Dense(1024, input_dim=3, kernel_initializer='normal', activation='tanh'))
        model.add(Dense(1024,  kernel_initializer='normal', activation='tanh'))
     	model.add(Dense(1, kernel_initializer='normal'))
	# Compile model
	model.compile(loss='mean_squared_error', optimizer='adam')
	return model
seed = 7
np.random.seed(seed)
# evaluate model with standardized dataset
clf = KerasRegressor(build_fn=baseline_model, nb_epoch=100000, batch_size=40,verbose=0)

clf.fit(X_train,Y_train)
res = clf.predict(X_test)


import matplotlib.pyplot as plt
plt.plot(Y_test,'b.-')
plt.plot(res,'ro-');
plt.show()


