import cv2
from keras.models import Sequential
from loader import train, to_char
from keras.layers import Dense, Activation, Convolution2D, MaxPooling2D, Flatten, Dropout, Reshape
import numpy as np

camera = cv2.VideoCapture(0)

model = Sequential([
    Reshape((1, 20, 20), input_shape=(400,)),
    Convolution2D(4, 3, 3, input_shape=(1, 20, 20)),
    MaxPooling2D(pool_size=(2, 2)),
    Convolution2D(16, 3, 3),
    Activation('relu'),
    # MaxPooling2D(pool_size=(2, 2)),
    Convolution2D(128, 3, 3, border_mode='valid'),
    Activation('relu'),
    # Convolution2D(256, 3, 3),
    # Activation('relu'),
    # MaxPooling2D(pool_size=(2, 2)),
    # Dropout(0.3),
    Flatten(),
    # Dense(128),
    # Dropout(0.4),
    Dense(56),
    Dropout(0.3),
    Dense(62),
    Dropout(0.2),
    Activation('softmax'),
])
np_char = np.vectorize(lambda x: to_char(x))
model.load_weights("model.wt")
cv2.startWindowThread()
cv2.namedWindow("preview")
while(True):
    ret, frame = camera.read()
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    (height, width) = gray.shape
    ix = 100
    cropped_image = gray[(height-ix)/2:(height-ix)/2+ix,(width-ix)/2:(width-ix)/2+ix]
    # cv2.imwrite('test.bmp', cropped_image)
    image = cv2.resize(cropped_image,None,fx=20.0/ix, fy=20.0/ix, interpolation = cv2.INTER_CUBIC)
    # cv2.imwrite('test.bmp', image)
    cv2.imshow('preview', cropped_image)
    image_array= image.T.reshape((1,400))
    # image_array= image.reshape((1,400))
    image_array=(image_array-128)/255.0
    possible_char = model.predict_proba(image_array)
    confidence = possible_char.max()
    # possible_char=model.predict(image_array)
    predicted=possible_char.argmax(axis=1)
    output = np_char(predicted)
    print output, confidence
    cv2.waitKey(200)