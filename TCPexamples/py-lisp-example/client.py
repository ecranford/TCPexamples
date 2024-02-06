#Copyright (c) 2024 Edward Cranford
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this
# software and associated documentation files (the "Software"), to deal in the Software
# without restriction, including without limitation the rights to use, copy, modify,
# merge, publish, distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to the following
# conditions:
#
# The above copyright notice and this permission notice shall be included in all copies
# or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
# PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
# HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
# CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
# OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import socket
import json
import random

HOST = "127.0.0.1"
PORT = 9894

# DANGER, DANGER: This is pretty simple minded. It has no error handling or checking of
#                 data for the correct format. If anything isn't just as it's expected to
#                 be Bad Things will happen and there will be tears.

# Create a socket (SOCK_STREAM means a TCP socket)
def connect_socket():
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:
        # Connect to server and send data
        sock.connect((HOST, PORT))
        print(f"# connected to port '{PORT}'")
        sock.sendall(bytes(data + "\n", "utf-8"))

        # Receive data from the server and shut down
        received = str(sock.recv(1024), "utf-8")

    print(f"# received message '{received}'")
    received = json.loads(received)
    print(f"# decoded JSON {received}")

if __name__== "__main__":
    while True:
        word = input("Enter a word (leave blank to quit):")
        if not word:
            break
        repeat = int(input("Enter number of repetitions:"))

        if not isinstance(repeat,int):
            repeat = random.randint(1,5)
            print("NaN, returning random:", repeat)

        data = {"word": word, "repeat": repeat}
        print(f"# request '{data}'")
        data = json.dumps(data) + "\n"
        print(f"# sending '{data}'")
        connect_socket()


