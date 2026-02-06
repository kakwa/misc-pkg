# Name of the package
NAME = talosctl

# Version
VERSION = 1.12.2

# Revision number
RELEASE = 1

# URL of the project
URL = https://github.com/siderolabs/talos

# short summary of what the package provides
SUMMARY = CLI for Talos Linux (Kubernetes OS)

# Long version of the summary
DESCRIPTION = talosctl is the CLI for Talos Linux, a modern OS designed for Kubernetes. It is used to configure, deploy, and manage Talos Linux nodes.

# License of the upstream project
LICENSE = MPL-2.0

# NIST Vulnerability Database CPE pattern
NVD_CPE_PATTERN=cpe:2.3:o:siderolabs:talos_linux:*

# Distribution versions to skip
SKIP=<=:deb:12 <=:el:7 <=:fc:29 <=:ubu:24.4

# Allow network for Go module download
COWBUILD_BUILD_ADDITIONAL_ARGS = --use-network yes
MOCK_BUILD_ADDITIONAL_ARGS = --enable-network

###############################################################################
# Source: Talos source tarball from GitHub (build talosctl from source)
###############################################################################

URL_SRC = $(URL)/archive/refs/tags/v$(VERSION).tar.gz

# Including common rules and targets
include buildenv/Makefile.common

$(SOURCE_ARCHIVE): $(SOURCE_DIR) $(CACHE) Makefile MANIFEST $(DIRECTORIES)
	@$(WGS) -u $(URL_SRC) -o $(BUILD_DIR)/talos-$(VERSION).tar.gz -C $(CACHE_DIR) -m $(MANIFEST_FILE)
	@tar -xf $(BUILD_DIR)/talos-$(VERSION).tar.gz -C $(BUILD_DIR)
	@rm -rf $(SOURCE_DIR)
	@mv $(BUILD_DIR)/talos-$(VERSION) $(SOURCE_DIR)
	@$(SOURCE_TAR_CMD)
