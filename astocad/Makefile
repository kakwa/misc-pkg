# Name of the package
NAME=astocad

# Not Versionned so we create our own
VERSION=2025.08.07

# Projects & Assets revision to recover
URL=https://github.com/AstoCAD/FreeCAD/tree/AstoCAD
COMMIT=214716b2833df45ffb7798a82ae557f870886fc6

URL_BRANDING=https://github.com/AstoCAD/astocad-feedstock
COMMIT_BRANDING=a7133a990bcd28265fbbdba43136abab97844710

URL_ADDONMANAGER=https://github.com/FreeCAD/AddonManager
COMMIT_ADDONMANAGER=e8f58715d31934749e54bdb4b355244ad58ecc85

URL_ONDSELSOLVER=https://github.com/FreeCAD/OndselSolver
COMMIT_ONDSELSOLVER=09d6175a2ba69e7016fcecc4f384946a2f84f92d

# Revision number 
RELEASE = 1

# short summary of what the package provides
SUMMARY=AstoCAD, an opensource multiplatform 3D parametric modeler based on FreeCAD. 

# Long version of the summary, but I'm lazy
DESCRIPTION=$(SUMMARY)

# License of the upstream project
LICENSE=GPLv2

# Security Monitoring
NVD_CPE_PATTERN=cpe:2.3:*:*:freecad:*

# Comma separated list of CVEs to ignore
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

# preparation hook for sources.
#
# Includes:
# * Ondsel Solver (necessary for the assembly workbench)
# * AddonManager (addon downloader)
# * Branding (replace the FreeCAD one)
#
# Rename base directory

$(SOURCE_ARCHIVE): $(SOURCE_DIR) $(CACHE) Makefile MANIFEST
	@$(WGS) -u $(URL_SRC) -O $(NAME)-$(VERSION).tar.gz
	@tar -vxf $(CACHE_DIR)/$(NAME)-$(VERSION).tar.gz -C $(SOURCE_DIR) --strip-components=1
	@$(WGS) -u $(BRANDING_URL_SRC) -O $(NAME)-feedstock-$(VERSION).tar.gz
	@tar -vxf $(CACHE_DIR)/$(NAME)-feedstock-$(VERSION).tar.gz -C  $(SOURCE_DIR) \
		--strip-components=2 -- $$(tar -tzf $(CACHE_DIR)/$(NAME)-feedstock-$(VERSION).tar.gz | grep '^.*/recipe/branding/$$')
	@$(WGS) -u $(URL_ADDONMANAGER)/archive/$(COMMIT_ADDONMANAGER).tar.gz -O addonmanager.tar.gz
	@tar -xf $(CACHE_DIR)/addonmanager.tar.gz -C $(SOURCE_DIR)/src/Mod/AddonManager --strip-components=1
	@$(WGS) -u $(URL_ONDSELSOLVER)/archive/$(COMMIT_ONDSELSOLVER).tar.gz -O ondselsolver.tar.gz
	@tar -xf $(CACHE_DIR)/ondselsolver.tar.gz -C $(SOURCE_DIR)/src/3rdParty/OndselSolver --strip-components=1
	@$(SOURCE_TAR_CMD)
