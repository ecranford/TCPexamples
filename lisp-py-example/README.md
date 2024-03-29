This is a trivial example of a Common Lisp process communicating with a Python process over TCP, using JSON.

The Python process is the "server" and the Lisp process the "client," with the interaction essentially
a remote procedure call from Lisp to Python. The Lisp process creates a randomly populated message,
containing a string _word_ and a positive integer _repeat_. It packages them up into a JSON object
and sends it, line delimited, to the server. The Python process decodes the JSON and constructs
a pair of return values, the first the *word* repeated *repeat* times, separated by hyphens, and the
second a float, the natural logarithm of the length of the first return value. It packages these up
as a JSON object, and sends it, again line delimited, to the Lisp process. Both processes print several
lines about what is going on.

To run this

- first open a terminal window and run `python server.py`  
    (you should see a blank line, and blinking cursor, indicating the server is up and awaiting input)  

- then in a Lisp listener load `client.lisp` and call `(run)`  
    (the client will run once; you can run the client again by typing `(run)` again)

To exit  
- exit `client.lisp` by typing '(exit)' and press 'return'  
- exit `server.py` by pressing 'ctrl-c'  


The server code requires Python version 3.7 or later. The Lisp code has only been tested in SBCL version 2.1.10, but should run in any recent, modern Common Lisp implementation that supports `usocket` (e.g., CCL).

Requirements:  
Python version 3.7 or later and 'socketserver', 'json', and 'math' packages  
Common Lisp (e.g., SBCL or CCL) and Quiklisp installed  
