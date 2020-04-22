#
# wget http://cloudmesh.github.io/get/romeo/tf/tf_sample.py
#
import os
import warnings
import tensorflow as tf
import logging

with warnings.catch_warnings():
    warnings.filterwarnings("ignore", category=FutureWarning)

logging.getLogger('tensorflow').setLevel(logging.FATAL)

os.environ["TF_CPP_MIN_LOG_LEVEL"] = "2"

if tf.test.is_gpu_available():
    print("------------------------------")
    print("GPU AVAILABLE")
    names = tf.test.gpu_device_name()
    print("------------------------------")
    print("GPU Device Names")
    print(names)