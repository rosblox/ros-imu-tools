#!/bin/bash

REPOSITORY_NAME="$(basename "$(dirname -- "$( readlink -f -- "$0"; )")")"

docker run -it --rm \
--network=host \
--ipc=host --pid=host \
--env UID=$(id -u) \
--env GID=$(id -g) \
--env ROS_DOMAIN_ID=23 \
--volume ./imu_tools/imu_complementary_filter:/colcon_ws/src/imu_tools/imu_complementary_filter \
--volume ./imu_tools/imu_filter_madgwick:/colcon_ws/src/imu_tools/imu_filter_madgwick \
ghcr.io/rosblox/${REPOSITORY_NAME}:humble
