# gazebo_trajectory_tutorials
example for using joint trajectory action with gazebo and roseus

require [gazebo_ros_demos](https://github.com/ros-simulation/gazebo_ros_demos)

### launch simulation ###
```
roslaunch gazebo_trajectory_tutorials rrbot_gazebo.launch
```

### control robot from interpreter ###
```
roseus euslisp/rrbot-interface.l
(in roseus)
roseus$ (rrbot-init)
roseus$ (send *ri* :angle-vector #f(30 30))
```
