(require 'json)

(setq chef-base-directory
      (expand-file-name "~/Development/github/maniaphobic/dendrite/chef"))

(defun find-chef-config (dirs file)
  (if (eq dirs nil) nil
    (let ((path (concat (car dirs) "/" file)))
      (if (file-exists-p path) path (find-chef-config (cdr dirs) file)))))

(defun load-chef-config ()
  (process-send-string
   "irb"
   (format "
require 'chef/config'
require 'chef/node'
Chef::Config.from_file('%s')
\n" (find-chef-config
     (list default-directory (concat default-directory "/.chef") "~/.chef")
     "knife.rb"))))

(defun launch-irb (version gemset)
    (rvm-use version gemset)
    (unless (get-buffer-process "irb")
      (start-process "irb" "irb" "irb" "--noprompt")))

(defun chef/get (object)
  (cond ((eq object :nodes)
	 (process-send-string "irb" "Chef::Node.list.to_json\n"))
	 nil))

(defun chef/explore (base-directory)
  (let ((default-directory chef-base-directory))
    (launch-irb "2.2" "(default)")
    (load-chef-config)
    (chef/get :nodes)
    )
  )

(defun needs-more-work ()
  (let ((start (process-mark (get-process "irb")))
	end)
    (process-send-string "irb" "
Chef::Node.list.to_json
\n")
    (setq end (process-mark (get-process "irb")))
    (save-excursion
      (switch-to-buffer "irb")
      (buffer-substring start end)))
  (json-read-from-string (buffer-substring start end))
  )

(defun stop-irb () (delete-process "irb"))

; Application entry point

(chef/explore chef-base-directory)
