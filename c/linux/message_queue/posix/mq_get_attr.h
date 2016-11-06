/**
  \file mq_get_attr.h
  \desc Header file of mq_get_attr
  \author "Gilson Varghese" <gilsonvarghese7@gmail.com>
  \date 6 Nov 2016
*/

/**
  \Includes
*/

#include <mqueue.h>
#include <errno.h>
#include <fcntl.h>
#include <stdio.h>

/**
	\Macros
*/
#define SUCCESS 0
#define FAILURE 0
#define MQ_PATH "/home/gilson/Learning"

/**
	\Function declaration
*/

int createMessageQueue();
