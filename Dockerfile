ARG ROS_DISTRO

FROM ros:${ROS_DISTRO}-ros-core

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    python3-colcon-common-extensions \
    python3-rosdep \
    && rm -rf /var/lib/apt/lists/*

COPY ros_entrypoint.sh .

WORKDIR /colcon_ws

COPY ./imu_tools/imu_complementary_filter src/imu_tools/imu_complementary_filter
COPY ./imu_tools/imu_filter_madgwick src/imu_tools/imu_filter_madgwick

RUN rosdep init && rosdep update && apt-get update && rosdep install --from-paths src -i -y --rosdistro humble \
    && rm -rf /var/lib/apt/lists/*

RUN . /opt/ros/${ROS_DISTRO}/setup.sh && \
    colcon build --symlink-install --event-handlers console_direct+ --cmake-args ' -DCMAKE_BUILD_TYPE=Release'

RUN echo 'alias build="colcon build --symlink-install  --event-handlers console_direct+"' >> /etc/bash.bashrc
RUN echo 'source /colcon_ws/install/setup.bash; ros2 run imu_complementary_filter complementary_filter_node' >> /run.sh && chmod +x /run.sh
RUN echo 'alias run="su - ros /run.sh"' >> /etc/bash.bashrc
