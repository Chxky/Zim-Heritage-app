#!/bin/bash

# Exit on error
set -e

echo "Installing Flutter..."
if [ ! -d "flutter" ]; then
  git clone https://github.com/flutter/flutter.git -b stable --depth 1
fi
export PATH="$PATH:$PWD/flutter/bin"

echo "Flutter version:"
flutter --version

echo "Getting dependencies..."
flutter pub get

echo "Building for web..."
flutter build web --release
