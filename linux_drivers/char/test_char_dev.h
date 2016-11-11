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

#define MAJOR_NUM

#define IOCTL_SET_MSG _IOR(MAJOR_NUM, 0, char *)

#define IOCTL_GET_MSG _IOR(MAJOR_NUM, 1, char *)

#define IOCTL_SET_NTH_BYTE _IOR(MAJOR_NUM, 2, int)

#endif