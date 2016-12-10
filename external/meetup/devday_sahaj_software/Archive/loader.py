from PIL import Image
import numpy as np
import pandas as pd
labels = pd.read_csv("trainLabels.csv")


def to_char(v):
    if v<10:
        v = v+ord("0")
    elif v<10+26:
        v = v-10+ord("A")
    else:
        v=v-10-26+ord("a")
    return chr(v)



def img2arr(i):
    im = Image.open("trainResized/" + str(i) + ".bmp").convert('L') #Can be many different formats.
    pix = im.load()
    d=[]
    for i in range(20):
        #d.append([])
        for j in range(20):
            d.append((pix[i,j]-128)/255.0)
            # d[i].append([(pix[i,j]-128)/255.0])
    return d

def one_hot(row):
    global labels
    if (row>len(labels)): return None
    val = labels["Class"][row-1]
    v=[0]*62
    st = encode(val)

    v[st] = 1
    return v;

def encode(val):
    st = 0
    val = ord(val)
    if val >= ord("a"):
        st = 26 + 10 + val - ord("a")
    elif val >= ord("A"):
        st = 10 + val - ord("A")
    elif val >= ord("0"):
        st = 0 + val - ord("0")
    return st


class DataSource:
    def __init__(self):
        self.start =1

    def next_batch(self, lim):
        #print "batch %s to %s" %(self.start, self.start+lim)
        yval = np.array([one_hot(i) for i in range(self.start, self.start+lim)])

        xval = np.array([img2arr(i) for i in range(self.start, self.start + lim)])
        self.start += lim
        return (xval, yval)

    def skip(self, lim):
        self.start += lim

    def reset(self):
        self.start = 1;
train = DataSource()

# a,b= train.next_batch(10)
# print len(a[0])
# print len(b[0])