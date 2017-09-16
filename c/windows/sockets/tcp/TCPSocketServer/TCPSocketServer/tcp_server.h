/**
	\File TCP server declarations and includes
	\Author Gilson Varghese <gilsonvarghese7@gmail.com>
	\Date September 16 2017
*/
#undef UNICODE
#define WIN32_LEAN_AND_MEAN

#include <Windows.h>
#include <WinSock2.h>
#include <WS2tcpip.h>
#include <stdlib.h>
#include <stdio.h>

/**
	\Brief Function declarations
*/
int initServer();
int startServer();

/**
	\Brief Sockets for server and incoming client
*/
SOCKET ListenSocket;
SOCKET ClientSocket;