# Name of the package
NAME = docker-registry

# Version (matches upstream distribution tag v$(VERSION))
VERSION = 3.1.0

# Revision number
RELEASE = 1

# URL of the project
URL = https://github.com/distribution/distribution

# short summary of what the package provides
SUMMARY = OCI container registry (Distribution reference implementation)

# Long version of the summary
DESCRIPTION = The registry server implements the OCI Distribution Specification for storing and serving container images and related content. This package builds the registry binary from the CNCF Distribution project sources.

# License of the upstream project
LICENSE = Apache-2.0

# NIST Vulnerability Database CPE pattern (distribution / Docker Registry 2 lineage)
NVD_CPE_PATTERN = cpe:2.3:a:docker:registry:*:*:*:*:*:*:*:*

# Allow Go module and toolchain download during package build
COWBUILD_BUILD_ADDITIONAL_ARGS = --use-network yes
MOCK_BUILD_ADDITIONAL_ARGS = --enable-network

SKIP=<=:deb:12 >=:el:0 >=:fc:0 >=:ubu:0.0

###############################################################################
# Source: upstream release tarball from GitHub
###############################################################################

URL_SRC = $(URL)/archive/refs/tags/v$(VERSION).tar.gz

# Including common rules and targets
include buildenv/Makefile.common

$(SOURCE_ARCHIVE): $(SOURCE_DIR) $(CACHE) Makefile MANIFEST $(DIRECTORIES)
	@$(WGS) -u $(URL_SRC) -O $(NAME)-$(VERSION).tar.gz
	@tar -xf $(CACHE_DIR)/$(NAME)-$(VERSION).tar.gz -C $(SOURCE_DIR) --strip-components=1
	@$(SOURCE_TAR_CMD)
