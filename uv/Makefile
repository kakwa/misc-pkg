# Name of the package
NAME = uv

# Version
VERSION = 0.11.19

# Revision number
RELEASE = 1

# URL of the project
URL=https://github.com/astral-sh/uv

# short summary of what the package provides
SUMMARY=An extremely fast Python package and project manager

# Long version of the summary, but I'm lazy
DESCRIPTION=$(SUMMARY)

# License of the upstream project
LICENSE=MIT

# Distribution versions to skip
#
# format: space separated list of rules.
# each rule have the format "<op>:<dist>:<version>", with:
#   <op>:      the operation (must be  '>', '>=', '<', '<=' or '=')
#   <dist>:    the distribution code name (examples: 'deb', 'el', 'fc')
#   <version>: the version number to ignore
#
SKIP=>=:el:0 >=:fc:0

# Allow network inside chroot/mock for fetching Rust git deps
COWBUILD_BUILD_ADDITIONAL_ARGS=--use-network yes
MOCK_BUILD_ADDITIONAL_ARGS=--enable-network

###############################################################################
# Rule #
########

URL_SRC=$(URL)/archive/$(VERSION).tar.gz

# Including common rules and targets
include buildenv/Makefile.common

# preparation hook for sources
#
# use 'make manifest' to generate/update this manifest file.
$(SOURCE_ARCHIVE): $(SOURCE_DIR) $(CACHE) Makefile MANIFEST
	@$(WGS) -u $(URL_SRC) -O $(NAME)-$(VERSION).tar.gz
	@tar -xf $(CACHE_DIR)/$(NAME)-$(VERSION).tar.gz -C $(SOURCE_DIR) --strip-components=1
	@$(SOURCE_TAR_CMD)
