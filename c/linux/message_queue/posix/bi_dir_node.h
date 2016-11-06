/**
	\file bi_dir_node.h
	\author Gilson Varghese <gilsonvarghese7@gmail.com>
	\description Header file for bi_dir_node.h 
*/

/**
	Macros
*/
#define SUCCESS 0
#define FAILURE -1

/**
	Class declaration	
*/

class MessageQueue {
private:

public:
	/**
		Create a message queue
	*/
	MessageQueue();

	/**
		Send a message
	*/
	int sendMessage();

	/**
		Receive a message
	*/
	int recvMessage();
};