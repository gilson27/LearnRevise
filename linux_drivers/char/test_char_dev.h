/**
  \file test_char_dev.h
  \desc The header file with ioctl definitions
*/

#ifndef CHARDEV_H
#define CHARDEV_H

#include <linux/ioctl.h>

/**
  The device major number
*/

#define MAJOR_NUM 100

#define IOCTL_SET_MSG _IOR(MAJOR_NUM, 109, char *)

#define IOCTL_GET_MSG _IOR(MAJOR_NUM, 121, char *)

#define IOCTL_GET_NTH_BYTE _IOWR(MAJOR_NUM, 122, int)

#define DEVICE_FILE_NAME "/dev/char_dev"

#endif