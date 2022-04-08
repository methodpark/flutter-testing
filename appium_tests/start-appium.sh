#!/bin/bash

set -e

cd $(dirname $0)/src

export ANDROID_SDK_ROOT=~/Android/Sdk/
npx appium
