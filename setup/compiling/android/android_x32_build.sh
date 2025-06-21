#!/bin/bash
set -e

# Set HAXELIB_PATH to .haxelib in the project directory
export HAXELIB_PATH="$(pwd)/.haxelib"
echo "[INFO] Using HAXELIB_PATH=$HAXELIB_PATH"

# Install required libraries from libraries.json FIRST
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

# THEN setup Android environment
echo "[INFO] Running Lime Android setup..."
haxelib run lime setup android

# THEN build APK
echo "[INFO] Building Android 32-bit APK..."
lime build android -32

echo "[SUCCESS] Android 32-bit APK built successfully!"
