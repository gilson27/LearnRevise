#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/fs.h>
#include <asm/uaccess.h>

#include "test_char_dev.h"
#define SUCCESS 0
#define DEVICE_NAME "char_dev"
#define BUF_LEN 80

/**
  flag to prevent cuncurrent access
*/

static int Device_Open;

/**
 * The message the device will give when asked 
 */
static char Message[BUF_LEN];

/**
  Used in device read. Pointer to avoid size overflow.
*/
static char *Message_Ptr;

/**
  Called when device starts
*/
static int device_open(struct inode *inode, struct file *file) {
  printk(KERN_INFO "device_open %p", file);
  /**
    Don't talk to two processes at the same time
  */
  if(Device_Open) {
    return -EBUSY;
  }

  Device_Open++;
  /**
    Initialize the message
  */
  Message_Ptr = Message;
  try_module_get(THIS_MODULE);
  return SUCCESS;
}

/**
  Called when device is removed
*/
static int device_release(struct inode *inode, struct file *file) {
  printk(KERN_INFO "In driver release (%p %p)", inode, file);
  Device_Open--;
  module_put(THIS_MODULE);
  return SUCCESS;
}

/**
  Called when a process which opened the device file tries to read from it.
*/
static int device_read(struct file *file, char __user * buffer,
                      size_t length, loff_t offset) {
  int bytes_read = 0;
  printk(KERN_INFO "In device Read (%p %p %d)", file, buffer, length);

  /**
    Check for end of file
  */
  if(*Message_Ptr == 0) {
    return 0;
  }

  /**
    Read byte by byte and put into user space buffer
  */
  while(length && *Message_Ptr) {
    put_user(*(Message_Ptr++), buffer++);
    length--;
    bytes_read++;
  }
  printk(KERN_INFO "Read %d bytes. %d left", bytes_read, length);
  return bytes_read;
}

/**
  This function is called when somebody tries to write to a device driver
*/
static int device_write(struct file *file, char __user *buffer, 
                        size_t length, loff_t offset) {
  int i;

  printk(KERN_INFO "In device write %p %p %d", file, buffer, length);
  for(i=0; i<length && i<BUF_LEN; ++i) {
    get_user(Message[i], buffer+i);
  }
  Message_Ptr = message;
  return i;
}

/**
  Implements IOCTL calls in the device
*/
static int device_ioctl(struct inode *inode, struct file *file, .
  unsigned int ioctl_num, unsigned long ioctl_param) {
  int i;
  char *temp,
  char ch;

  switch(ioctl_num) {
    case IOCTL_SET_MESSAGE: 
      /**
        Receive a pointer to a message(in user space) and set that
        to be device's message. Get the parameter given by ioctl 
        by the process
      */
      temp = (char *)ioctl_param;

      /**
        Find the length of the message
      */
      get_user(ch, temp);
      for(i=0; ch&& i<BUF_LEN; i++, temp++){
        get_user(ch, temp);
      }
      device_write(file, (char *)ioctl_param, i, 0);
    break;
    case IOCTL_GET_MESSAGE: 
      /**
        Give the current message to the calling process-
        the parameter we got is a pointer, fill it
      */
      i = device_read(file, (char *)ioctl_param, 99, 0);
      /**
        Put a zero at the end of the buffer,
        so it will be properly terminated
      */
      put_user('\0', (char *)ioctl_param + i);
    break;
    case IOCTL_GET_NTH_BYTE: 
      /**
        The ioctel is both input and output
      */
      return Message[ioctl_param];
    break;
    default:
      printk(KERN_WARNING "IOCTL %d not supported", ioctl_num);
  }
  return 0;
}

/**
  Module Declarations
*/
/**
  The structure will call the functions whenever there action on 
  the device. The structure can not be local to 
  init module, since the pointer is kept in device table. The
  default value is null if undefined 
*/
struct file_operations Fops = {
  .read = device_read,
  .write = device_write,
  .open = device_open,
  .release = device_release,
  .ioctl = device_ioctl
};

/**
  Initialize the module. Register the charecter device
*/
int init_module() {
  int ret_val;
  /**
    Register charecter device
  */
  ret_val = register_chrdev(MAJOR_NUM, DEVICE_NAME, &Fops);
  /**
    Check errors
  */
  if(ret_val < 0) {
    printk(KERN_ALERT "%s failed with %d", "Registering charecter device", ret_val);
    return ret_val;
  }
  printk(KERN_INFO "%s. Major device number is %d", "Registration is success", MAJOR_NUM);
  return 0;
}

void cleanup_module() {
  int ret_val;
  ret_val = unregister_chrdev(MAJOR_NUM, DEVICE_NAME);
  if(ret_val < 0) {
    printk(KERN_ALERT "Unable to unregister device %d", ret_val);
  }
}
