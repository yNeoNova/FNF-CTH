#!/bin/bash

set -e

# Set HAXELIB_PATH to .haxelib in the project directory
export HAXELIB_PATH="$(pwd)/.haxelib"

echo "[INFO] Using HAXELIB_PATH=$HAXELIB_PATH"

# Setup Android (Java, SDK, NDK paths, etc.)
echo "[INFO] Running Lime Android setup..."
haxelib run lime setup android

# Install required libraries from libraries.json
echo "[INFO] Installing libraries..."
libraries_file="libraries.json"

if [ ! -f "$libraries_file" ]; then
    echo "[ERROR] libraries.json not found at $libraries_file"
    exit 1
fi

jq -c '.dependencies[]' "$libraries_file" | while read dep; do
    name=$(echo "$dep" | jq -r '.name')
    version=$(echo "$dep" | jq -r '.version')

    echo "[INFO] Installing $name@$version..."
    haxelib install "$name" "$version"
done

echo "[INFO] All libraries installed."

# Start the Android build (32-bit in this case)
lime build android -32

echo "[SUCCESS] Android 32-bit APK built successfully!"
