import warnings
from keras.callbacks import Callback, EarlyStopping
from keras.optimizers import SGD
from keras.models import Sequential
from loader import train, to_char
from keras.layers import Dense, Activation, Convolution2D, MaxPooling2D, Flatten, Dropout, Reshape
import numpy as np
import pandas as pd

train_dataset, train_labels = train.next_batch(4000)
# train_dataset, train_labels = train.next_batch(64)
# test_dataset,test_labels = train.next_batch(1000 )
valid_dataset,valid_labels = train.next_batch(100)
# actual = valid_labels.argmax(axis=1)

class LearningRateDecayAndEarlyStopping(Callback):
    def __init__(self, monitor='val_loss', patience=0, verbose=0, mode='auto', lr=0.1):
        super(LearningRateDecayAndEarlyStopping, self).__init__()
        self.monitor = monitor
        self.patience = patience
        self.verbose = verbose
        self.wait = 0
        self.nstep = 10
        self.step = 0
        self.lr = lr
        if mode not in ['auto', 'min', 'max']:
            warnings.warn('EarlyStopping mode %s is unknown, '
                          'fallback to auto mode.' % (self.mode), RuntimeWarning)
            mode = 'auto'
        if mode == 'min':
            self.monitor_op = np.less
        elif mode == 'max':
            self.monitor_op = np.greater
        else:
            if 'acc' in self.monitor:
                self.monitor_op = np.greater
            else:
                self.monitor_op = np.less
    def on_train_begin(self, logs={}):
        self.wait = 0       # Allow instances to be re-used
        self.best = np.Inf if self.monitor_op == np.less else -np.Inf
        self.model.optimizer.lr.set_value(self.lr)
    def on_epoch_end(self, epoch, logs={}):
        current = logs.get(self.monitor)
        if current is None:
            warnings.warn('Early stopping requires %s available!' %
                          (self.monitor), RuntimeWarning)
        if self.monitor_op(current, self.best):
            self.best = current
            self.model.save_weights('best.wt', overwrite=True)
            self.wait = 0
        else:
            if self.wait >= self.patience:
                if self.step >= self.nstep:
                    if self.verbose > 0:
                        print('Epoch %05d: early stopping' % (epoch))
                    self.model.stop_training = True
                else:
                    self.step += 1
                    self.lr = self.lr / 3.0
                    print('Epoch %05d: step : %d reducing lr %s' % (epoch,self.step, self.lr))
                    self.model.optimizer.lr.set_value(self.lr)
                    self.wait = 0
            self.wait += 1


model = Sequential([
    Reshape((1, 20, 20), input_shape=(400,)),
    Convolution2D(64, 3, 3, input_shape=(1, 20, 20)),
    Convolution2D(256, 3, 3),
    Activation('relu'),
    MaxPooling2D(pool_size=(2, 2)),
    Convolution2D(512, 3, 3, border_mode='valid'),
    Convolution2D(512, 3, 3, border_mode='valid'),
    Activation('relu'),
    Convolution2D(256, 3, 3),
    Activation('relu'),
    MaxPooling2D(pool_size=(2, 2)),
    Dropout(0.5),
    Flatten(),
    Dense(378),
    Dense(108),
    Dropout(0.5),
    Dense(62),
    Activation('softmax'),
])


sgd = SGD(lr=0.01, decay=0, momentum=0.9, nesterov=True)
model.compile(loss='categorical_crossentropy', optimizer=sgd)

model.fit(train_dataset, train_labels, nb_epoch=100, validation_split=0.1,
          callbacks=[LearningRateDecayAndEarlyStopping(monitor='loss', patience=5, verbose=1, lr=0.1)])

# callbacks=[val_callback,EarlyStopping(monitor='val_loss', patience=5, verbose=1)])
# model.save_weights("test")

v=model.predict(valid_dataset)
predicted=v.argmax(axis=1)
np_char = np.vectorize(lambda x: to_char(x))
output = np_char(predicted)
outdf = pd.DataFrame({"ID":range(6284, 12504)})
outdf["Class"] = output
outdf.to_csv("output.csv", index=False)


model.evaluate(train_dataset, train_labels)
# model.train_on_batch(X_batch, Y_batch)

# loss_and_metrics = model.evaluate(X_test, Y_test, batch_size=32)

# classes = model.predict_classes(X_test, batch_size=32)
# proba = model.predict_proba(X_test, batch_size=32)
score = model.evaluate(valid_dataset, valid_labels, batch_size=32)
v=model.predict(valid_dataset)
predicted=v.argmax(axis=1)
# np_char = np.vectorize(lambda x: to_char(x))
# output = np_char(predicted)
# outdf = pd.DataFrame({"ID":range(6284, 12504)})
# outdf["Class"] = output
# outdf.to_csv("output1.csv", index=False)
f=open("out2.log", "a")
f.write("%s %2.3f\n"%(score, (predicted == actual).sum()/1000.0))
f.close()

# run(53)

# for i in [7,21,37,53,108,221,456,741,1048]:
#     run(i)
# for i in [37,43,48,53,58,61,68,72]:
# for i in range(3):
#     run(best)