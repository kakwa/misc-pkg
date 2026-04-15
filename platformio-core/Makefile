# Name of the package
NAME = platformio-core

# Version
VERSION = 6.1.18

# Revision number 
RELEASE = 1

# URL of the project 
URL = https://github.com/platformio/platformio-core

# short summary of what the package provides
SUMMARY = An open-source ecosystem for IoT development

# Long version of the summary
DESCRIPTION = PlatformIO Core is a professional collaborative platform for embedded development with no vendor lock-in. It provides support for 50+ development platforms, 20+ frameworks and 1000+ embedded boards with debugging, unit testing, static code analysis, and remote device management.

# License of the upstream project
LICENSE = Apache-2.0

# Distribution versions to skip
#
# format: space separated list of rules.
# each rule have the format "<op>:<dist>:<version>", with:
#   <op>:      the operation (must be  '>', '>=', '<', '<=' or '=')
#   <dist>:    the distribution code name (examples: 'deb', 'el', 'fc')
#   <version>: the version number to ignore
#
#SKIP=<=:deb:8 <=:el:6 <=:fc:29 <=:ubu:18.4

# Allow network for pip dependencies
COWBUILD_BUILD_ADDITIONAL_ARGS = --use-network yes
MOCK_BUILD_ADDITIONAL_ARGS = --enable-network

###############################################################################
# Rule #
########

# source recovery url
URL_SRC = $(URL)/archive/refs/tags/v$(VERSION).tar.gz

# Including common rules and targets 
include buildenv/Makefile.common

# preparation hook for sources
# source archive must be recovered here, optionally reworked, and
# moved to $(SOURCE_ARCHIVE) (the expected path of the source archive for the
# rest of the build)
#
# $(WGS) should be the preferred way to recover archives
# (add checksum against a manifest file).
# use 'make manifest' to generate/update this manifest file.

$(SOURCE_ARCHIVE): $(SOURCE_DIR) $(CACHE) Makefile MANIFEST
	@$(WGS) -u $(URL_SRC) -O $(NAME)-$(VERSION).tar.gz
	@tar -xf $(CACHE_DIR)/$(NAME)-$(VERSION).tar.gz -C $(SOURCE_DIR) --strip-components=1
	@$(SOURCE_TAR_CMD)
