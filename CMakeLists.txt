cmake_minimum_required(VERSION 2.8.3)
project(gazebo_trajectory_tutorials)

find_package(catkin REQUIRED)

catkin_package()

find_package(euscollada)
set(_collada2eus_exe ${euscollada_PREFIX}/lib/euscollada/collada2eus_urdfmodel)
if (NOT EXISTS ${_collada2eus_exe})
  message (WARNING "Could not find ${_collada2eus_exe}")
endif()

find_package(rrbot_description)
set(_rrbot_xacro ${rrbot_description_SOURCE_PREFIX}/urdf/rrbot.xacro)
if (NOT EXISTS ${_rrbot_xacro})
  message (WARNING "Could not find ${_rrbot_xacro}")
endif()

find_package(xacro)
set(_xacro_exe ${xacro_PREFIX}/bin/xacro)
if (NOT EXISTS ${_xacro_exe})
  message (WARNING "Could not find ${_xacro_exe}")
endif()

add_custom_target(create_urdf_model_done ALL
  COMMAND ${_xacro_exe} ${_rrbot_xacro} > ${PROJECT_SOURCE_DIR}/models/rrbot.urdf
  #COMMAND ${_collada2eus_exe} -L -I ${PROJECT_SOURCE_DIR}/models/rrbot.urdf -C ${PROJECT_SOURCE_DIR}/models/rrbot.yaml -O ${PROJECT_SOURCE_DIR}/models/rrbot.l
  COMMAND ${_collada2eus_exe} -I ${PROJECT_SOURCE_DIR}/models/rrbot.urdf -C ${PROJECT_SOURCE_DIR}/models/rrbot.yaml -O ${PROJECT_SOURCE_DIR}/models/rrbot.l
  DEPENDS ${PROJECT_SOURCE_DIR}/models/rrbot.yaml
  )

install(DIRECTORY launch
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION})

install(DIRECTORY config
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION})

install(DIRECTORY models
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION})
