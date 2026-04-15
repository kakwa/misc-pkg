# Name of the package
NAME = python3-ajsonrpc

# Version
VERSION = 1.2.0

# Revision number 
RELEASE = 1

# URL of the project 
URL = https://github.com/pavlov99/ajsonrpc

# short summary of what the package provides
SUMMARY = Async JSON-RPC 2.0 protocol + server powered by asyncio

# Long version of the summary
DESCRIPTION = ajsonrpc is a Python library that implements the JSON-RPC 2.0 protocol with support for asyncio. It provides both client and server implementations with support for various async frameworks like Sanic and Quart.

# License of the upstream project
LICENSE = MIT

# NIST Vulnerability Database CPE pattern (default: cpe:2.3:*:*:$(NAME):*)
# CPE values can be discovered at: https://kakwa.github.io/cpe-search/
NVD_CPE_PATTERN = cpe:2.3:*:ajsonrpc_project:ajsonrpc:*:*:*:*:*:*:*:*

# Comma separated list of CVEs to ignore
#NVD_IGNORE_CVES=CVE-2023-1234,CVE-2023-5678

# Minimum Version for CVEs (default: $(VERSION))
# Set to 0 for all CVEs
#NVD_MIN_VERSION=0.0.1

# Distribution versions to skip
#
# format: space separated list of rules.
# each rule have the format "<op>:<dist>:<version>", with:
#   <op>:      the operation (must be  '>', '>=', '<', '<=' or '=')
#   <dist>:    the distribution code name (examples: 'deb', 'el', 'fc')
#   <version>: the version number to ignore
#
#SKIP=<=:deb:8 <=:el:6 <=:fc:29 <=:ubu:18.4

###############################################################################
# Rule #
########

# source recovery url
URL_SRC = $(URL)/archive/refs/tags/$(VERSION).tar.gz

# Including common rules and targets 
include buildenv/Makefile.common

# preparation hook for sources
# source archive must be recovered here, optionaly reworked, and
# moved to $(SOURCE_ARCHIVE) (the expected path of the source archive for the
# rest of the build)
#
# $(WGS) should be the prefered way to recover archives
# (add checksum against a manifest file).
# use 'make manifest' to generate/update this manifest file.

$(SOURCE_ARCHIVE): $(SOURCE_DIR) $(CACHE) Makefile MANIFEST
	@$(WGS) -u $(URL_SRC) -O $(NAME)-$(VERSION).tar.gz
	@tar -xf $(CACHE_DIR)/$(NAME)-$(VERSION).tar.gz -C $(SOURCE_DIR) --strip-components=1
	@$(SOURCE_TAR_CMD)

# Example of simple recovery, with good upstream
#$(SOURCE_ARCHIVE): $(SOURCE_DIR) $(CACHE) Makefile MANIFEST
#	$(WGS) -u $(URL_SRC) -o $(SOURCE_ARCHIVE)

# more complex case with upstream source rework and rebuilding of the tar
#$(SOURCE_ARCHIVE): $(SOURCE_DIR) $(CACHE) Makefile MANIFEST
#	$(WGS) -u $(URL_SRC) -o $(BUILD_DIR)/$(NAME)-$(VERSION).tar.gz
#	mkdir -p $(BUILD_DIR)/tmp
#	tar -vxf $(BUILD_DIR)/$(NAME)-$(VERSION).tar.gz -C $(BUILD_DIR)/tmp
#	rm -rf $(BUILD_DIR)/tmp/$(NAME)-$(VERSION)/debian
#	mv $(BUILD_DIR)/tmp/$(NAME)-$(VERSION)/* $(SOURCE_DIR)
#	rm -rf $(BUILD_DIR)/tmp
#	rm -f $(BUILD_DIR)/$(NAME)-$(VERSION).tar.gz
#	$(SOURCE_TAR_CMD)
