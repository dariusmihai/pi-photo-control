import socket
import sys
 
# Create a connection to the server application on port 81
tcp_socket = socket.create_connection(('192.168.33.33', 3456))
 
try:
    data = '{t: 3, f: 5, p: 1}'.encode()
    tcp_socket.sendall(data)
 
finally:
    print("Closing socket")
    tcp_socket.close()