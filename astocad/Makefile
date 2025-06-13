# Name of the package
NAME = astocad

# Not Versionned so we create our own
VERSION = 2025.05.22
COMMIT=f3061debedacda10df4b447d9dedc891c38a6c64
COMMIT_BRANDING=31157e96409b64b6f665eba45219b27638d65004
COMMIT_ADDONMANAGER=69a6e0dc7b8f5fe17547f4d1234df1617b78c45e

# Revision number 
RELEASE = 1

# URL of the project 
URL=https://github.com/AstoCAD/FreeCAD/tree/AstoCAD
URL_BRANDING=https://github.com/AstoCAD/astocad-feedstock
URL_ADDONMANAGER=https://github.com/FreeCAD/AddonManager

# short summary of what the package provides
SUMMARY=AstoCAD, an opensource multiplatform 3D parametric modeler based on FreeCAD. 

# Long version of the summary, but I'm lazy
DESCRIPTION=$(SUMMARY)

# License of the upstream project
LICENSE=GPLv2

NVD_CPE_PATTERN=cpe:2.3:*:*:freecad:*

# Comma separated list of CVEs to ignore
# Use it if false positive.
NVD_IGNORE_CVES=CVE-2021-45844,CVE-2021-45845

# Minimum Version for CVEs, defaults to $(VERSION)
# Set to empty string to remove any version constraints
NVD_MIN_VERSION=0.0.1

# Distribution versions to skip
#
# format: space separated list of rules.
# each rule have the format "<op>:<dist>:<version>", with:
#   <op>:      the operation (must be  '>', '>=', '<', '<=' or '=')
#   <dist>:    the distribution code name (examples: 'deb', 'el', 'fc')
#   <version>: the version number to ignore
#
SKIP=<=:deb:8 >=:el:0 >=:fc:0 <=:ubu:18.4

###############################################################################
# Rule #
########

# example of source recovery url
URL_SRC=https://github.com/AstoCAD/FreeCAD/archive/$(COMMIT).tar.gz

BRANDING_URL_SRC=$(URL_BRANDING)/archive/$(COMMIT_BRANDING).tar.gz

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

# Example of simple recovery, with good upstream
#$(SOURCE_ARCHIVE): $(SOURCE_DIR) $(CACHE) Makefile MANIFEST
#	$(WGS) -u $(URL_SRC) -o $(SOURCE_ARCHIVE)

$(SOURCE_ARCHIVE): $(SOURCE_DIR) $(CACHE) Makefile MANIFEST
	@$(WGS) -u $(URL_SRC) -O $(NAME)-$(VERSION).tar.gz
	@tar -vxf $(CACHE_DIR)/$(NAME)-$(VERSION).tar.gz -C $(SOURCE_DIR) --strip-components=1
	@$(WGS) -u $(BRANDING_URL_SRC) -O $(NAME)-feedstock-$(VERSION).tar.gz
	@tar -vxf $(CACHE_DIR)/$(NAME)-feedstock-$(VERSION).tar.gz -C  $(SOURCE_DIR) \
		--strip-components=2 -- $$(tar -tzf $(CACHE_DIR)/$(NAME)-feedstock-$(VERSION).tar.gz | grep '^.*/recipe/branding/$$')
	@mkdir -p $(SOURCE_DIR)/src/Mod/AddonManager
	@$(WGS) -u $(URL_ADDONMANAGER)/archive/$(COMMIT_ADDONMANAGER).tar.gz -O addonmanager.tar.gz
	@tar -xf $(CACHE_DIR)/addonmanager.tar.gz -C $(SOURCE_DIR)/src/Mod/AddonManager --strip-components=1
	@$(SOURCE_TAR_CMD)
