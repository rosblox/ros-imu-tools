ARG ROS_DISTRO

FROM ros:${ROS_DISTRO}-ros-core

RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-${ROS_DISTRO}-imu-tools \
    && rm -rf /var/lib/apt/lists/*
