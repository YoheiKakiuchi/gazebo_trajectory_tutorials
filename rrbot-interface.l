(require :rrbot "package://gazebo_trajectory_tutorials/models/rrbot.l")
;;(require :rrbot-utils "package://gazebo_trajectory_tutorials/rrbot-utils.l")
(require :robot-interface "package://pr2eus/robot-interface.l")

(defclass rrbot-interface
  :super robot-interface
  :slots ()
  )
(defmethod rrbot-interface
  (:init
   (&rest args)
   (send-super* :init :robot rrbot-robot
		:namespace "rrbot"
		:groupname "rrbot_interface" args))
  ;;
  (:default-controller
   ()
   (list
    (list
     (cons :controller-action "rrbot_arm_controller/follow_joint_trajectory")
     (cons :controller-state  "rrbot_arm_controller/state")
     (cons :action-type control_msgs::FollowJointTrajectoryAction)
     (cons :joint-names (list "joint1" "joint2"))
     ))
   )
  )

(defun rrbot-init (&rest args)
  (if (not (boundp '*ri*))
      (setq *ri* (instance* rrbot-interface :init args)))
  (if (not (boundp '*rrbot*))
      (setq *robot* (rrbot)))
  )
