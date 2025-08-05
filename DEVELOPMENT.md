# Development Setup

This project automates kernel compilation in Linux environments using GitHub Actions.

## 🛠️ Local Development

### Prerequisites

- Linux environment (Ubuntu/Debian recommended)
- Git
- curl and jq for API testing
- Build tools for kernel compilation (if testing locally)

### File Permissions

```bash
# Make scripts executable
chmod +x scripts/*.sh
```

### Testing Scripts

#### Check for new versions

```bash
./scripts/check_versions.sh
```

#### Test local build (requires build environment)

```bash
./scripts/local_build.sh [KERNEL_TAG] [KERNELSU_RELEASE]
```

## 📋 Development Workflow

1. **Edit files** - Use any editor
2. **Test locally** - Run scripts to verify functionality
3. **Commit and push** - Standard git workflow
4. **GitHub Actions** - Automatically handles execution

## 🔧 Build Environment Setup (for local testing)

### Install required packages

```bash
sudo apt-get update
sudo apt-get install -y \
    build-essential \
    bc \
    bison \
    flex \
    libssl-dev \
    libelf-dev \
    git \
    curl \
    wget \
    zip \
    unzip \
    python3 \
    python3-pip \
    device-tree-compiler \
    cpio \
    rsync \
    jq \
    ccache \
    fakeroot \
    lz4 \
    mkbootimg \
    android-sdk-platform-tools-common
```

### Test API access

```bash
# Test kernel API
curl -s https://api.github.com/repos/arter97/android_kernel_nothing_sm8475/tags | jq -r '.[0].name'

# Test KernelSU API
curl -s https://api.github.com/repos/KernelSU-Next/KernelSU-Next/releases/latest | jq -r '.tag_name'
```

## 📁 Project Structure

```
├── .github/workflows/
│   └── kernel-build.yml          # Main automation workflow
├── scripts/
│   ├── check_versions.sh         # Version checker
│   └── local_build.sh           # Local build tester
├── last_versions.txt             # Version tracking (auto-updated)
├── README.md                     # Main documentation
└── .gitignore                    # Git ignore patterns
```
