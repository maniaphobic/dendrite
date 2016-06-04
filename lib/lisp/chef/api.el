(defun dendrite/chef (method object)
  (let ((head (car object))
	(tail (cdr object)))
    (cond ((eq head :nodes)
	   (dendrite/chef/nodes method tail))
	  )
    )
  )

(defun dendrite/chef/nodes (method details)
  (let (())
    )
  (dendrite/request/send "Chef::Node.list.to_json\n")
  )

(defun dendrite/request/send (ruby)
  (dendrite/response/receive (process-send-string "irb" ruby)))

