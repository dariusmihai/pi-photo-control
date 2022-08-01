from asyncio.windows_events import NULL
import socket
import sys

tcp_socket = NULL

def connect():
    # Set up a TCP/IP server
    tcp_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
 
    # Bind the socket to server address and port 81
    server_address = ('0.0.0.0', 3456)
    tcp_socket.bind(server_address)
 
    # Listen on port 81
    tcp_socket.listen(1)

def main_loop():
    while True:
        print("Waiting for connection")
        connection, client = tcp_socket.accept()
 
        try:
            print("Connected to client IP: {}".format(client))
         
            # Receive and print data 32 bytes at a time, as long as the client is sending something
            while True:
                data = connection.recv(32)
                print("Received data: {}".format(data))
                process_call(data)
 
                if not data:
                    break
 
        finally:
            connection.close()

def process_call(data):
    print("Processing data")

connect()
main_loop()