#!/bin/sh
sdk_version=$1
project_path=$2
target_platform=$3

sdk_name="renpy-${sdk_version}-sdk"

# Download SDK
echo "Download SDK..."
if wget https://www.renpy.org/dl/${sdk_version}/${sdk_name}.tar.bz2; then
    echo "SDK downloaded successfully."
else
    echo "SDK download failed."
    return 1
fi

# Unzip SDK
echo "Unzip SDK..."
tar -xjf ./${sdk_name}.tar.bz2
mv ./${sdk_name} /${sdk_name}

# Determine packaging commands based on platform
case $3 in
win | linux | mac | android | market | web)
    build_cmd="/${sdk_name}/renpy.sh /${sdk_name}/launcher distribute --package ${target_platform} ${project_path}"
    ;;
*)
    build_cmd="/${sdk_name}/renpy.sh /${sdk_name}/launcher distribute ${project_path}"
    ;;
esac

# Build
echo "Build project..."
if $build_cmd; then
    artifact_path=$(ls | grep '\-dists')
    ::set-output name=artifact_path::$artifact_path
    ::set-output name=version::${artifact_path%'-dists'}
else
    return 1
fi