(require 'json)

(let ((default-directory "~/Development/github/maniaphobic/dendrite/chef"))
  (rvm-use "2.2.1" "(default")
  (start-process "irb" "irb" "irb")
  )

(process-send-string "irb" "
require 'chef/config'
require 'chef/node'
Chef::Config.from_file('./.chef/knife.rb')
\n")

(process-send-string "irb" "
Chef::Node.list
\n"
)

(process-mark (get-process "irb"))
