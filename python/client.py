import socket
import sys

server_address = None
tcp_socket = None

def init():
    global server_address
    server_address = input("Enter server address")

def connect():
    global tcp_socket
    tcp_socket = socket.create_connection((server_address, 3456))

def send(data: str):
    try:
        data = data.encode()
        tcp_socket.sendall(data)
 
    finally:
        print("Closing socket")
        tcp_socket.close()

init()
connect()
send('{t: 3, f: 5, p: 1}')