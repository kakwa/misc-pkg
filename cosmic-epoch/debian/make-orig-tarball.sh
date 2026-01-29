#!/bin/bash
# Script to create orig tarball with submodules for Debian packaging

set -e

PACKAGE_NAME="cosmic-epoch"
VERSION="${1:-1.0.4}"
UPSTREAM_REPO="https://github.com/pop-os/cosmic-epoch.git"
TAG="${2:-epoch-${VERSION}}"

echo "Creating orig tarball for ${PACKAGE_NAME} version ${VERSION}"
echo "Using git tag: ${TAG}"

# Create temporary directory
TMPDIR=$(mktemp -d)
trap "rm -rf ${TMPDIR}" EXIT

cd "${TMPDIR}"

# Clone with submodules
echo "Cloning repository with submodules..."
git clone --recurse-submodules --branch "${TAG}" "${UPSTREAM_REPO}" "${PACKAGE_NAME}-${VERSION}"

cd "${PACKAGE_NAME}-${VERSION}"

# Remove .git directories to reduce size
echo "Removing .git directories..."
find . -name ".git" -type d -exec rm -rf {} + 2>/dev/null || true
find . -name ".gitmodules" -delete 2>/dev/null || true
find . -name ".gitignore" -delete 2>/dev/null || true

cd ..

# Create tarball
TARBALL="${PACKAGE_NAME}_${VERSION}.orig.tar.xz"
echo "Creating tarball: ${TARBALL}"
tar -cJf "${TARBALL}" "${PACKAGE_NAME}-${VERSION}"

# Move to original directory
mv "${TARBALL}" "${OLDPWD}/"

echo "Tarball created successfully: ${OLDPWD}/${TARBALL}"
echo ""
echo "To build the package:"
echo "  1. Extract: tar -xf ${TARBALL}"
echo "  2. Enter directory: cd ${PACKAGE_NAME}-${VERSION}"
echo "  3. Build: dpkg-buildpackage -us -uc -b"
