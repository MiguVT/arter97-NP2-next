#!/bin/bash

# Helper script to manually check for new versions
# Usage: ./check_versions.sh

echo "=== Version Checker ==="

# Get latest tag from arter97 kernel
echo "Getting latest kernel tag..."
LATEST_KERNEL_TAG=$(curl -s https://api.github.com/repos/arter97/android_kernel_nothing_sm8475/tags | jq -r '.[0].name')
echo "Latest kernel tag: $LATEST_KERNEL_TAG"

# Get latest release from KernelSU Next
echo "Getting latest KernelSU Next release..."
LATEST_KERNELSU_RELEASE=$(curl -s https://api.github.com/repos/KernelSU-Next/KernelSU-Next/releases/latest | jq -r '.tag_name')
echo "Latest KernelSU release: $LATEST_KERNELSU_RELEASE"

# Read previously processed versions
echo "Reading previous versions..."
LAST_KERNEL_TAG=""
LAST_KERNELSU_RELEASE=""

if [ -f "last_versions.txt" ]; then
    LAST_KERNEL_TAG=$(grep "KERNEL_TAG=" last_versions.txt | cut -d'=' -f2)
    LAST_KERNELSU_RELEASE=$(grep "KERNELSU_RELEASE=" last_versions.txt | cut -d'=' -f2)
fi

echo "Last processed kernel tag: $LAST_KERNEL_TAG"
echo "Last processed KernelSU release: $LAST_KERNELSU_RELEASE"

# Check for changes
echo ""
echo "=== Status ==="

if [ "$LATEST_KERNEL_TAG" != "$LAST_KERNEL_TAG" ]; then
    echo "✅ NEW KERNEL TAG DETECTED: $LATEST_KERNEL_TAG"
else
    echo "❌ No new kernel tag"
fi

if [ "$LATEST_KERNELSU_RELEASE" != "$LAST_KERNELSU_RELEASE" ]; then
    echo "✅ NEW KERNELSU RELEASE DETECTED: $LATEST_KERNELSU_RELEASE"
else
    echo "❌ No new KernelSU release"
fi

echo ""
echo "Release name that would be created: $LATEST_KERNELSU_RELEASE-$LATEST_KERNEL_TAG"
