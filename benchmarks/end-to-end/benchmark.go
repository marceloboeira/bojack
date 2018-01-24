package main

import (
	"net"
)

func main() {
	conn, _ := net.Dial("tcp", "127.0.0.1:5000")
	conn.Write([]byte("set a 0\n"))

	for n := 0; n < 100; n++ {
		conn.Write([]byte("increment a\n"))
	}

	conn.Close()
}
