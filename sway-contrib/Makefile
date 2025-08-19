# Name of the package
NAME = sway-contrib

# Version
VERSION = 1.11

# Revision number
RELEASE = 1

# URL of the project (upstream GitHub)
URL = https://github.com/OctopusET/sway-contrib

# Source archive download URL
URL_SRC = https://github.com/OctopusET/sway-contrib/archive/refs/tags/$(VERSION).tar.gz

# Short summary of what the package provides
SUMMARY = User-contributed scripts for the Sway window manager

# Long version of the summary
DESCRIPTION = $(SUMMARY)

# License of the upstream project
LICENSE = MIT

# Include shared rules and build targets
include buildenv/Makefile.common

# Skip RPM
SKIP=<=:deb:8 >=:el:0 >=:fc:0 <=:ubu:18.4

# Preparation hook for sources: fetch archive via WGS and move it to $(SOURCE_ARCHIVE)
$(SOURCE_ARCHIVE): $(SOURCE_DIR) $(CACHE) Makefile MANIFEST
	$(WGS) -u $(URL_SRC) -o $(SOURCE_ARCHIVE)
