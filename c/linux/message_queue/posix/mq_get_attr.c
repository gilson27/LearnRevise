/**
  \file mq_get_attr.c
  \desc Example of mq_get_attr
  \author "Gilson Varghese" <gilsonvarghese7@gmail.com>
  \date 6 Nov 2016
*/

/**
  \Includes
*/

#include "mq_get_attr.h"

int main() {
  int returnValue;
  returnValue = createMessageQueue();
  if(returnValue == FAILURE) {
    goto shutdown;
  }
  return SUCCESS;

shutdown:
  return FAILURE;
}

/**
  \function  createMessageQueue
  \return {int} Status of the function
*/
int createMessageQueue() {
  mqd_t mqd;
  struct mq_attr qAttr;
  mqd = mq_open(MQ_PATH, O_RDWR | O_CREAT);
  if(mqd == -1) {
    perror("mq_open failed ");
    return -1;
  }

  /**
    Read messageQueue attrs and check for errors
  */
  if(mq_getattr(mqd, &qAttr) == FAILURE) {
    perror("mq_open failed ");
    return -1;
  }

  fprintf(stdout, "flags: 0x%x maxmsg: %d msgsize: %d curmsgs: %d",
    qAttr.mq_flags, qAttr.mq_maxmsg, qAttr.mq_msgsize, qAttr.mq_curmsgs);
  return SUCCESS;
}
