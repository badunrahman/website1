#!/bin/bash

# Create a build directory if it doesn't exist
mkdir -p build

# Copy HTML, CSS, and JavaScript files to the build directory
cp index.html build/
cp style.css build/
cp script.js build/
cp -R assets build/

echo "Build completed!"
