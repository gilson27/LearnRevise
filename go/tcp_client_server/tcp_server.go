package main

import (
	"fmt"
  "net"
  "bufio"
	"strings"
)

func main() {
	fmt.Println("Launching Server");
	ln, _ := net.Listen("tcp", ":8081");
	for {	
		conn, _ := ln.Accept();
		message, _ := bufio.NewReader(conn).ReadString('\n')
		fmt.Println("Message Received:", string(message))
		newmessage := strings.ToUpper(message)
		conn.Write([]byte(newmessage+"\n"))
	}
}
