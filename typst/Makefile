# Name of the package
NAME = typst

# Version
VERSION = 0.14.0.101

# Revision number 
RELEASE = 1

# URL of the project 
URL=https://github.com/typst/typst

# short summary of what the package provides
SUMMARY=A new markup-based typesetting system that is powerful and easy to learn.

# Long version of the summary, but I'm lazy
DESCRIPTION=$(SUMMARY)

# License of the upstream project
LICENSE=Apache-2.0

# Distribution versions to skip
#
# format: space separated list of rules.
# each rule have the format "<op>:<dist>:<version>", with:
#   <op>:      the operation (must be  '>', '>=', '<', '<=' or '=')
#   <dist>:    the distribution code name (examples: 'deb', 'el', 'fc')
#   <version>: the version number to ignore
#
SKIP=<=:deb:12 >=:el:0 >=:fc:0 <=:ubu:23.10

# Allow network inside chroot/mock for fetching Rust git deps
COWBUILD_BUILD_ADDITIONAL_ARGS=--use-network yes
MOCK_BUILD_ADDITIONAL_ARGS=--enable-network

###############################################################################
# Rule #
########

UPSTREAM_COMMIT=630fbbec415c5d0dd854b62d6039b11dd10c4961
URL_SRC=$(URL)/archive/$(UPSTREAM_COMMIT).tar.gz

# Including common rules and targets 
include buildenv/Makefile.common

# preparation hook for sources
#
# use 'make manifest' to generate/update this manifest file.
$(SOURCE_ARCHIVE): $(SOURCE_DIR) $(CACHE) Makefile MANIFEST
	@$(WGS) -u $(URL_SRC) -O $(NAME)-$(VERSION).tar.gz
	@tar -vxf $(CACHE_DIR)/$(NAME)-$(VERSION).tar.gz -C $(SOURCE_DIR) --strip-components=1
	@rm -rf $(SOURCE_DIR)/debian
	@$(SOURCE_TAR_CMD)
