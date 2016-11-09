package main

import(
	"net"
	"fmt"
	"bufio"
	"os"
);


func main() {
	conn, _ := net.Dial("tcp", "127.0.0.1:8081")
	reader := bufio.NewReader(os.Stdin)
	fmt.Println("Enter Test to Send")
	text, _ := reader.ReadString('\n')
	fmt.Fprintf(conn, text+"\n")
	message, _ := bufio.NewReader(conn).ReadString('\n')
	fmt.Printf("Message From the server: " + message)
}
