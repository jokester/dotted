#!/bin/bash

# sets (local-specific settings / sign settings / computed attributes) on a CI server (I'm using jenkins)

# DO NOT commit this file and sign keys into repository

# JDK & SDK
export ANDROID_HOME=/somewhere/android-sdk-linux
export JAVA_HOME=/somewhere/jdk1.8.0_65

# SIGN
export ANDROID_KEYSTORE_PATH=/somewhere/keys.jks
export ANDROID_SIGN_APK=yes
export ANDROID_KEYSTORE_PASS=secret
export ANDROID_KEY_ALIAS=secret
export ANDROID_KEY_PASS=secret

# versionCode: number of commits that are reachable from here
# *supposedly* monotonically increasing for each release build
export ANDROID_VERSION_CODE="$(git rev-list HEAD --count)"
# versionName: first 8 chars in commit SHA1
export ANDROID_VERSION_NAME="${GIT_COMMIT:0:8}"

exec sh gradlew clean aR