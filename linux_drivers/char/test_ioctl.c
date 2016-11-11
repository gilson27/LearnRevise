/**
  IOCTL program to 
  talk to chardev
*/

#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/ioctl.h>

#include "test_char_dev.h"

/**
  Read device using ioctl 
*/
int get_data_from_device(int file_ptr) {
  int ret_val;
  int message[100];
  ret_val = ioctl(file_ptr, IOCTL_GET_MSG, message);
  if(ret_val < 0) {
    fprintf(stderr, "%s%d\n", "IOCTL failed with ret_val = ", ret_val);
    return ret_val;
  }
  return 0;
}

/**
  Write device using ioctl
*/
int put_data_to_the_device(int file_ptr, char *message) {
  int ret_val;
  ret_val = ioctl(file_ptr, IOCTL_SET_MSG, message);
  if(ret_val < 0) {
    fprintf(stderr, "%s%d\n", "IOCTL failed with ret_val = ", ret_val);
    return ret_val;
  }
  return 0;
}

/**
  Get nth chrecter from the current buffer
*/
int get_nth_char_from_device(int file_ptr) {
  int i = 0;
  char c;
  do {
    c = ioctl(file_ptr, IOCTL_SET_MSG, i++);
    if(c < 0) {
      fprintf(stderr, "%s%d\n", "IOCTL failed for i = ", i);
      return c;
    }
    fprintf(stdout, "%c\n", c);
  } while(c != 0);
  return 0;
}

int main() {
  int devie_ptr, ret_val;
  char *message = "IOCTL message write";
  devie_ptr = open(DEVICE_FILE_NAME, 0);
  if(devie_ptr < 0) {
    printf("%s %s\n", "Cann't open the file ", DEVICE_FILE_NAME);
  }
  /**
    Write data and retrieve the same
  */
  get_data_from_device(devie_ptr);
  get_nth_char_from_device(devie_ptr);
  put_data_to_the_device(devie_ptr, message);
  return 0;
}

/**



  printk(KERN_INFO "If you want to talk to the device driver,\n");
  printk(KERN_INFO "you'll have to create a device file. \n");
  printk(KERN_INFO "We suggest you use:\n");
  printk(KERN_INFO "mknod %s c %d 0\n", DEVICE_FILE_NAME, MAJOR_NUM);
  printk(KERN_INFO "The device file name is important, because\n");
  printk(KERN_INFO "the ioctl program assumes that's the\n");
  printk(KERN_INFO "file you'll use.\n");

  */