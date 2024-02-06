;;; Copyright (c) 2024 Edward Cranford
;;;
;;; Permission is hereby granted, free of charge, to any person obtaining a copy of this
;;; software and associated documentation files (the "Software"), to deal in the Software
;;; without restriction, including without limitation the rights to use, copy, modify,
;;; merge, publish, distribute, sublicense, and/or sell copies of the Software, and to
;;; permit persons to whom the Software is furnished to do so, subject to the following
;;; conditions:
;;;
;;; The above copyright notice and this permission notice shall be included in all copies
;;; or substantial portions of the Software.
;;;
;;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
;;; INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
;;; PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
;;; HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
;;; CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
;;; OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

(ql:quickload '(:usocket-server :cl-json :vom))
(vom:config t :debug)

(defparameter +host+ "127.0.0.1")
(defparameter +port+ 9894)

;; DANGER, DANGER: This is pretty simple minded. It has no error handling or checking of
;;                 data for the correct format. If anything isn't just as it's expected to
;;                 be Bad Things will happen and there will be tears.


;;do something with the incoming message and generate an output
;;will be replaced with function(s) defining the cognitive model
(defun generate-response (json-msg)
  (let* ((word (cdr (assoc 'word json-msg)))
	 (repeat (cdr (assoc 'repeat json-msg)))
	 (string (format nil "~v@{~A-~:*~}" repeat word)))
    (setf string (subseq string 0 (1- (length string))))
    `((:string . ,string)
      (:x . ,(log (length string)))))
  )

;;process the incoming message and return a response
(defun process-request (stream)
  (handler-case
      (progn
	(vom:debug ";; Connection opened")
	(with-input-from-string (msg (read-line stream))
	  (vom:debug ";; Recieved message ~S" msg)
	  (let ((json:*json-symbols-package* nil))
	    (let ((json-msg (json:decode-json msg)))
	      (vom:debug ";; Decoded JSON is ~S" json-msg)
	      (let ((response (generate-response json-msg)))
		;;this is where the cog model would be called,
		;;and the output would be assigned to 'response'
		(vom:debug ";; Result is ~S" response)
		(setf response (json:encode-json-to-string response))
		(vom:debug ";; Sending ~S" response)
		(format stream "~S~%" response)
		(finish-output stream))))))
    (error (e) (vom:error "Error processing request: ~A" e)))
  )

(usocket:socket-server nil +port+ #'process-request)
