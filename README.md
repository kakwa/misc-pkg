[![Build Packages Repositories](https://github.com/kakwa/misc-pkg/actions/workflows/repos.yml/badge.svg)](https://github.com/kakwa/misc-pkg/actions/workflows/repos.yml)
[![NVD CVEs check](https://github.com/kakwa/misc-pkg/actions/workflows/vulncheck.yml/badge.svg)](https://github.com/kakwa/misc-pkg/actions/workflows/vulncheck.yml)

# misc-pkg

The `.deb`/`.rpm` repositories are available at the following url: https://kakwa.github.io/misc-pkg/

## Ubuntu/Debian

If you are using `Ubuntu`/`Debian`, here how to install the repository:

```shell
# If you are not root
export SUDO=sudo

# Get your OS version
. /etc/os-release
# Get the architecture
ARCH=$(dpkg --print-architecture)

# Add the GPG key
wget -qO - https://kakwa.github.io/misc-pkg/GPG-KEY.pub | \
    gpg --dearmor | ${SUDO} tee /etc/apt/trusted.gpg.d/misc-pkg.gpg >/dev/null

# Add the repository
echo "deb [arch=${ARCH}] \
https://kakwa.github.io/misc-pkg/deb.${VERSION_CODENAME}.${ARCH}/ \
${VERSION_CODENAME} main" | ${SUDO} tee /etc/apt/sources.list.d/misc-pkg.list

# update
apt update
```
## Build

This project uses [Pakste](https://github.com/kakwa/pakste).

Check the [Pakste Documention](https://kakwa.github.io/pakste/) for more details.
