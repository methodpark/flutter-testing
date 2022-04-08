#!/bin/bash

set -e

while test $# -gt 0
do
  case "$1" in
    -h|--help)
      showHelp=true
      ;;
    -r|--rebuild)
      rebuild=true
      ;;
    *)
      showHelp=true
      ;;
  esac
  shift
done

if [[ -n "$showHelp" ]]; then
  echo "$0 [-h|--help] [-r|--rebuild]"
  echo "  --help: show this help and exit"
  echo "  --rebuild: rebuild flutter app before testing"
  exit 0;
fi

cd "$(dirname "$0")"
baseDir="$(pwd)"

if [[ ! $(curl --silent localhost:4723) ]]; then
  echo "Appium not running on port 4723!"
  exit 1
fi

if [[ -n "$rebuild" ]]; then
  cd "$baseDir/../bloc_pattern_sample_app"
  fvm flutter build apk --debug --dart-define enableFlutterDriver=true
  adb uninstall com.example.bloc_pattern_sample_app
fi

cd "$baseDir/src"

export ANDROID_SDK_ROOT=~/Android/Sdk/ 
export APPIUM_OS=android
npm test
