# Android Kernel Automation with KernelSU Next

This repository automates the compilation of a custom Android kernel integrating KernelSU Next, based on arter97's kernel for Nothing Phone.

## 🎯 Objective

Automatically compile a custom kernel when detecting:

- **New tags** in [`arter97/android_kernel_nothing_sm8475`](https://github.com/arter97/android_kernel_nothing_sm8475)
- **New releases** in [`KernelSU-Next/KernelSU-Next`](https://github.com/KernelSU-Next/KernelSU-Next)

## 🔄 How It Works

### Automatic Monitoring

- Workflow runs **every 30 minutes** to check for new versions
- Automatically detects changes in both repositories
- Prevents duplicate builds by storing the last processed versions

### Build Process

1. **Download** kernel source code according to the new tag
2. **Automatic integration** of KernelSU Next using the official script
3. **Compilation** using the kernel's `build_kernel.sh` script
4. **Generation** of `boot.img` and `arter97-kernel-*-boot.img` files
5. **Automatic creation** of release with naming: `[KernelSU-Release]-[Kernel-Tag]`

## 📋 Main Files

```
.github/workflows/kernel-build.yml  # Main GitHub Actions workflow
scripts/check_versions.sh           # Script to manually check versions
scripts/local_build.sh             # Script for local build testing
last_versions.txt                   # Tracking of last processed versions
```

## 🛠️ Setup

### Requirements

- Repository with GitHub Actions enabled
- GitHub token with write permissions (automatic with `GITHUB_TOKEN`)

### Manual Execution

You can run the workflow manually from the "Actions" tab with the "Force build" option.

### Helper Scripts

#### Check versions

```bash
./scripts/check_versions.sh
```

#### Local build (requires Linux environment)

```bash
./scripts/local_build.sh [KERNEL_TAG] [KERNELSU_RELEASE]
```

## 📦 Artifacts and Releases

### Artifacts

- Uploaded as GitHub Actions artifacts with 30-day retention
- Include build information (`build_info.txt`)

### Releases

- **Naming**: `[KernelSU-Release]-[Kernel-Tag]`
- **Example**: `v0.7.5-arter97-13.0.A.4.2`
- **Assets**: All generated `.img` files + build information

## ⚠️ Warnings

- **Use at your own risk**: This is an automatically compiled custom kernel
- **Compatibility**: Specifically for Nothing Phone (SM8475)
- **Backup**: Always backup your boot partition before flashing

## 🔧 Kernel Installation

### Using Fastboot

```bash
fastboot flash boot boot.img
# or
fastboot flash boot arter97-kernel-*-boot.img
```

### Using Custom Recovery (TWRP/OrangeFox)

1. Download the `.img` file from the release
2. Flash from recovery as boot image
3. Reboot

## 📊 Workflow Status

| Component                 | Status    |
| ------------------------- | --------- |
| arter97 kernel monitoring | ✅ Active |
| KernelSU Next monitoring  | ✅ Active |
| Automatic build           | ✅ Active |
| Automatic release         | ✅ Active |

## 🤝 Credits

- **Kernel Source**: [arter97/android_kernel_nothing_sm8475](https://github.com/arter97/android_kernel_nothing_sm8475)
- **KernelSU Next**: [KernelSU-Next/KernelSU-Next](https://github.com/KernelSU-Next/KernelSU-Next)
- **Automation**: MiguVT

## 📄 License

This repository is under the same license as the original kernel source.
