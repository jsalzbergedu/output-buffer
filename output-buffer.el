;; -*- lexical-binding: t -*-

(defgeneric get-output-buffer (output-buffer) "Refresh and get the output buffer")

(defclass output-buffer ()
  ((internal-output-buffer :initform nil)
   (buffer-name :type string :initarg :buffer-name)))

(defmethod get-output-buffer ((output-buffer output-buffer))
  "Refresh and get the output buffer"
  (when (oref output-buffer internal-output-buffer)
    (kill-buffer (oref output-buffer internal-output-buffer)))
  (let ((new-output-buffer (get-buffer-create (oref output-buffer buffer-name))))
    (with-current-buffer new-output-buffer
      (insert "-*- mode: Text -*-\n")
      (set-buffer-major-mode new-output-buffer))
    (switch-to-buffer-other-window new-output-buffer)
    (oset output-buffer internal-output-buffer new-output-buffer)))

(defun make-output-buffer (name)
  "Make an output buffer with name NAME"
  (make-instance 'output-buffer :buffer-name name))

(provide 'output-buffer)
