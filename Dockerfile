ARG ROS_DISTRO

FROM ros:${ROS_DISTRO}-ros-core

RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-${ROS_DISTRO}-imu-complementary-filter \
    ros-${ROS_DISTRO}-imu-filter-madgwick \
    && rm -rf /var/lib/apt/lists/*
