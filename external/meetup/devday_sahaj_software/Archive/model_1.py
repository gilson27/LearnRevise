import warnings
from keras.callbacks import Callback, EarlyStopping
from keras.optimizers import SGD
from keras.models import Sequential
from loader import train, to_char
from keras.layers import Dense, Activation, Convolution2D, MaxPooling2D, Flatten, Dropout, Reshape
import numpy as np
import pandas as pd

train_dataset, train_labels = train.next_batch(6283)
# train_dataset, train_labels = train.next_batch(64)
# test_dataset,test_labels = train.next_batch(1000 )
valid_dataset,valid_labels = train.next_batch(6220)
# actual = valid_labels.argmax(axis=1)


model = Sequential([
    Reshape((20, 20, 1), input_shape=(400,)),
    Convolution2D(8, 3, 3, input_shape=(1, 20, 20)),
    MaxPooling2D(pool_size=(2, 2)),
    Convolution2D(32, 3, 3),
    Activation('relu'),
    MaxPooling2D(pool_size=(2, 2)),
    Convolution2D(128, 3, 3, border_mode='valid'),
    Activation('relu'),
    Dropout(0.3),
    Flatten(),
    # Dense(128),
    Dense(108),
    Dropout(0.3),
    Dense(62), # 26 alpha + 26 small caps alpha + 10 numbers
    Dropout(0.2),
    Activation('softmax'),
])


sgd = SGD(lr=0.01, decay=0, momentum=0.9, nesterov=True)
model.compile(loss='categorical_crossentropy', optimizer=sgd)

model.fit(train_dataset, train_labels, nb_epoch=100, validation_split=0.2)


v=model.predict(valid_dataset)
predicted=v.argmax(axis=1)
np_char = np.vectorize(lambda x: to_char(x))
output = np_char(predicted)
outdf = pd.DataFrame({"ID":range(6284, 12504)})
outdf["Class"] = output
outdf.to_csv("output_1.csv", index=False)


model.evaluate(train_dataset, train_labels)
# model.train_on_batch(X_batch, Y_batch)

# loss_and_metrics = model.evaluate(X_test, Y_test, batch_size=32)

# classes = model.predict_classes(X_test, batch_size=32)
# proba = model.predict_proba(X_test, batch_size=32)
# score = model.evaluate(valid_dataset, valid_labels, batch_size=32)
# v=model.predict(valid_dataset)
# predicted=v.argmax(axis=1)
# np_char = np.vectorize(lambda x: to_char(x))
# output = np_char(predicted)
# outdf = pd.DataFrame({"ID":range(6284, 12504)})
# outdf["Class"] = output
# outdf.to_csv("output1.csv", index=False)
# f=open("out2.log", "a")
# f.write("%s %2.3f\n"%(score, (predicted == actual).sum()/1000.0))
# f.close()

# run(53)

# for i in [7,21,37,53,108,221,456,741,1048]:
#     run(i)
# for i in [37,43,48,53,58,61,68,72]:
# for i in range(3):
#     run(best)