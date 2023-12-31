#!/bin/sh
sdk_version=$1
project_path=$2
target_platform=$3

sdk_name="renpy-${sdk_version}-sdk"

user_path=$(eval echo ~${USER})
sdk_path="${user_path}/${sdk_name}"

if [ ! -d ${sdk_path} ]; then
    # Download SDK
    echo "Download SDK..."
    if wget -q https://www.renpy.org/dl/${sdk_version}/${sdk_name}.tar.bz2; then
        echo "SDK downloaded successfully."
    else
        echo "SDK download failed."
        return 1
    fi
    
    # Unzip SDK
    echo "Unzip SDK..."
    tar -xjf ./${sdk_name}.tar.bz2

    mv ./${sdk_name} ${user_path}
    rm ./${sdk_name}.tar.bz2
else
    echo "SDK already exists."
fi

# Determine packaging commands based on platform
case $3 in
    win | linux | mac | android | market | web)
        build_cmd="${sdk_path}/renpy.sh ${sdk_path}/launcher distribute --package ${target_platform} ${project_path}"
    ;;
    *)
        build_cmd="${sdk_path}/renpy.sh ${sdk_path}/launcher distribute ${project_path}"
    ;;
esac

# Build
echo "Build project..."
if $build_cmd; then
    artifact_path=$(ls | grep '\-dists')
    version=${artifact_path%'-dists'}
    echo "artifact_path=$artifact_path" >>"$GITHUB_OUTPUT"
    echo "version=$version" >>"$GITHUB_OUTPUT"
else
    return 1
fi
