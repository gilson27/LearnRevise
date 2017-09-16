/**
	\File Main function for Socket server initialization
	\Author Gilson Varghese <gilsonvarghese7@gmail.com>
	\Date September 16 2017
*/

#include "tcp_server.h"

/**
	Main function
	\return
*/

int main() {
	/**
		Initialize server parameters
	*/
	initServer();
	/**
		Start server parameters
	*/
	startServer();
	return 0;
}