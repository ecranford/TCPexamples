This is a trivial example of a Common Lisp process communicating with a Python process over TCP, using JSON.

The Lisp process is the "server" and the Python process the "client," with the interaction essentially
a remote procedure call from Python to Lisp. The Python process prompts the user for a word, and a number.
It creates a message combining the _word_ and a positive integer _repeat_. It packages them up into a JSON
object and sends it, line delimited, to the server. The Lisp process decodes the JSON and constructs
a pair of return values, the first the *word* repeated *repeat* times, separated by hyphens, and the
second a float, the natural logarithm of the length of the first return value. It packages these up
as a JSON object, and sends it, again line delimited, to the Python process. Both processes print several
lines about what is going on.

To run this
- first in a Lisp listener load `server.lisp`  
    e.g. in a terminal window, navigate to the directory where the file exists and type:  
        sbcl --load "server.lisp"  
    (you should see a blank line, and blinking cursor, indicating the server is up and awaiting input)  

- then open a terminal window, navigate to the directory where the file exists and run `python client.py`  
    (you should see a prompt asking you to enter a word for which you may then enter any word)  

To exit
- exit `server.lisp` by pressing 'ctrl-break' or 'ctrl-pause'
- exit `client.py` by returning a null '' response when prompted for a word, or by pressing 'ctrl-c' at any time


The server code requires Python version 3.7 or later. The Lisp code has only been tested in SBCL version 2.1.10, 
but should run in any recent, modern Common Lisp implementation that supports `usocket` (e.g., CCL).

Requirements:  
Python version 3.7 or later and 'socket', 'json', and 'random' packages  
Common Lisp (e.g., SBCL or CCL) and Quiklisp installed
