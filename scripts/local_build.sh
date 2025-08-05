#!/bin/bash

# Script to simulate the build process locally
# Usage: ./local_build.sh [KERNEL_TAG] [KERNELSU_RELEASE]

set -e

KERNEL_TAG=${1:-$(curl -s https://api.github.com/repos/arter97/android_kernel_nothing_sm8475/tags | jq -r '.[0].name')}
KERNELSU_RELEASE=${2:-$(curl -s https://api.github.com/repos/KernelSU-Next/KernelSU-Next/releases/latest | jq -r '.tag_name')}

echo "=== Local Kernel Build ==="
echo "Kernel Tag: $KERNEL_TAG"
echo "KernelSU Release: $KERNELSU_RELEASE"
echo ""

# Create temporary directory
BUILD_DIR="build_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

echo "📥 Downloading kernel source code..."
git clone --depth=1 --branch="$KERNEL_TAG" \
    https://github.com/arter97/android_kernel_nothing_sm8475.git kernel_source

cd kernel_source

echo "🔧 Checking build tools..."
if [ ! -f "build_kernel.sh" ]; then
    echo "❌ Error: build_kernel.sh not found"
    exit 1
fi
chmod +x build_kernel.sh

echo "🔗 Integrating KernelSU Next..."
curl -LSs "https://raw.githubusercontent.com/KernelSU-Next/KernelSU-Next/next/kernel/setup.sh" | bash -

if [ -d "KernelSU" ]; then
    echo "✅ KernelSU integrated successfully"
else
    echo "⚠️  Warning: KernelSU directory not found"
fi

echo "🏗️  Starting compilation..."
export ARCH=arm64
export SUBARCH=arm64
export CROSS_COMPILE=aarch64-linux-android-

# Try to compile
echo "Executing build_kernel.sh..."
bash build_kernel.sh || {
    echo "❌ Compilation error"
    echo "Available files:"
    find . -name "*.sh" -o -name "Makefile" -o -name "defconfig" | head -10
    exit 1
}

echo "📦 Searching for generated files..."
find . -name "*.img" -type f | head -10

echo "✅ Build completed in: $(pwd)"
echo "To clean up: rm -rf $(pwd)"
