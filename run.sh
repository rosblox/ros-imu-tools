#!/bin/bash

REPOSITORY_NAME="$(basename "$(dirname -- "$( readlink -f -- "$0"; )")")"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

export HOST_UID=$(id -u)

docker compose -f $SCRIPT_DIR/docker-compose.yml run \
--volume ./imu_tools/imu_complementary_filter:/colcon_ws/src/imu_tools/imu_complementary_filter \
--volume ./imu_tools/imu_filter_madgwick:/colcon_ws/src/imu_tools/imu_filter_madgwick \
${REPOSITORY_NAME} bash
