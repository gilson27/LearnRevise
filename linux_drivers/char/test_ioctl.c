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

}

/**
  Write device using ioctl
*/
int put_data_to_the_device(int file_ptr) {

}

/**
  Get nth chrecter from the current buffer
*/
int get_nth_char_from_device(int file_ptr) {

}

int main() {
  int devie_ptr, ret_val;
  devie_ptr = open(DEVICE_FILE_NAME, O_WR);

  /**
    Write data and retrieve the same
  */
  put_data_to_the_device(devie_ptr);
  get_data_from_device(devie_ptr);
  get_nth_char_from_device(devie_ptr);
  return 0;
}