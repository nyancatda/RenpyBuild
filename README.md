# Ren'Py Build
GitHub action script for building your Ren'Py project

## Use
``` yarn
- name: Build
  uses: nyancatda/RenpyBuild@main
  with:
    sdk_version: '8.1.3'
```

## Available parameters
- `sdk_version` Ren'Py SDK version
- `project_path` Project folder path
- `target_platform` Build target platform, optional `win`|`linux`|`mac`|`android`|`market`|`web`

## Output
- `artifact_path` Path to the built artifact
- `version` Project version

## Cache
The script will store the downloaded SDK in `~/renpy-${sdk_version}-sdk`, and you can configure the cache yourself

Example
``` yml
- name: Restore Renpy SDK Cache
  id: restore-cache
  uses: actions/cache@v3
  with:
    path: /home/runner/work/_temp/_github_home/renpy-8.1.3-sdk
    key: renpy-8.1.3-sdk

- name: Build
  id: build
  uses: nyancatda/RenpyBuild@main
  with:
    sdk_version: '8.1.3'
```

## Thank
1. [ProjectAliceDev/renpy-build-action](https://github.com/ProjectAliceDev/renpy-build-action) Provides basic ideas