# RPM Build System
# ---------------

# RPM build directory structure
RPM_BUILD_DIRS := $(BUILD_DIR)/rpm.$(DIST)/BUILDROOT \
  $(BUILD_DIR)/rpm.$(DIST)/RPMS \
  $(BUILD_DIR)/rpm.$(DIST)/SRPMS \
  $(INDIVIDUAL_RPM_LOCAL_REPO_PATH)

RPM_SPEC := $(BUILD_DIR)/rpm.$(DIST)/SPEC/$(PKGNAME).spec
RPM_ARCHIVE := $(BUILD_DIR)/rpm.$(DIST)/SOURCES/$(PKGNAME)-$(VERSION).tar.gz

# Determine which RPM content files to use (distribution-specific or default)
RPM_CONTENT_DIST := $(filter-out \
  rpm/component.spec.dist.$(DIST), \
  $(wildcard rpm/*.dist.$(DIST)) \
)

RPM_CONTENT_BASE := $(filter-out $(wildcard rpm/*.dist.*) \
  rpm/component.spec, \
  $(wildcard rpm/*) \
)

# Select files that don't have distribution-specific versions
RPM_CONTENT_IN := $(RPM_CONTENT_DIST) \
  $(shell \
    for f in $(RPM_CONTENT_BASE); do \
      if ! [ -e $$f.dist.$(DIST) ]; then echo $$f; fi; \
    done \
  )

# Prepare output file paths
RPM_CONTENT_OUT := $(subst .dist.$(DIST),,\
  $(addprefix $(BUILD_DIR)/rpm.$(DIST)/SOURCES/, \
    $(subst rpm/,,$(RPM_CONTENT_IN))\
  )\
)

# Choose distribution-specific spec file if available
ifneq ("$(wildcard rpm/component.spec.dist.$(DIST))","")
RPM_SPEC_IN := rpm/component.spec.dist.$(DIST)
else
RPM_SPEC_IN := rpm/component.spec
endif

# Create RPM build directories
$(RPM_BUILD_DIRS): | $(BUILD_DIR)/rpm.$(DIST) $(DIRECTORIES)
	@mkdir -p $@

# Copy source archive to RPM build environment
$(RPM_ARCHIVE): $(SOURCE_ARCHIVE) | $(RPM_BUILD_DIRS)
	@mkdir -p $(BUILD_DIR)/rpm.$(DIST)/SOURCES
	@cp -f $(SOURCE_ARCHIVE) $(RPM_ARCHIVE)

# Copy additional content files to RPM build environment
$(RPM_CONTENT_OUT): $(RPM_CONTENT_IN) $(RPM_SPEC)
	@mkdir -p $(BUILD_DIR)/rpm.$(DIST)/SOURCES
	@f=rpm/$(subst $(BUILD_DIR)/rpm.$(DIST)/SOURCES/,,$@); \
	if [ -e $$f.dist.$(DIST) ]; then \
		cp -f $$f.dist.$(DIST) $@; \
	else \
		cp -f $$f $@; \
	fi

# Prepare RPM spec file with variable substitutions
$(RPM_SPEC): $(RPM_SPEC_IN) Makefile
	@mkdir -p $(BUILD_DIR)/rpm.$(DIST)/SPEC
	@cp $(RPM_SPEC_IN) $(RPM_SPEC)
	@sed -i 's|@NAME@|$(PKGNAME)|'                      $(RPM_SPEC) || (rm -f $(RPM_SPEC); exit 1)
	@sed -i 's|@LICENSE@|$(LICENSE)|'                   $(RPM_SPEC) || (rm -f $(RPM_SPEC); exit 1)
	@sed -i 's|@VERSION@|$(VERSION)|'                   $(RPM_SPEC) || (rm -f $(RPM_SPEC); exit 1)
	@sed -i 's|@RELEASE@|$(RELEASE)|'                   $(RPM_SPEC) || (rm -f $(RPM_SPEC); exit 1)
	@sed -i 's|@DESCRIPTION@|$(DESCRIPTION)|'           $(RPM_SPEC) || (rm -f $(RPM_SPEC); exit 1)
	@sed -i 's|@SUMMARY@|$(SUMMARY)|'                   $(RPM_SPEC) || (rm -f $(RPM_SPEC); exit 1)
	@sed -i 's|@URL@|$(URL)|'                           $(RPM_SPEC) || (rm -f $(RPM_SPEC); exit 1)
	@sed -i 's|@MAINTAINER@|$(MAINTAINER)|'             $(RPM_SPEC) || (rm -f $(RPM_SPEC); exit 1)
	@sed -i 's|@MAINTAINER_EMAIL@|$(MAINTAINER_EMAIL)|' $(RPM_SPEC) || (rm -f $(RPM_SPEC); exit 1)

# Define common rpmbuild options
define RPMBUILD_OPTIONS
--define "_topdir $(CURDIR)/$(BUILD_DIR)/rpm.$(DIST)" \
--define "_sourcedir %{_topdir}/SOURCES" \
--define "_specdir %{_topdir}/SPEC" \
--define "_rpmdir %{_topdir}/RPMS" \
--define "_srcrpmdir %{_topdir}/SRPMS" \
--define "_tmppath %{_topdir}/BUILDROOT" \
--define "_builddir %{_topdir}/BUILD" \
--define "dist .$(PKG_ORG)+$(DIST_CODE)$(DIST_TAG)"
endef

# Build binary RPM packages
$(BUILD_DIR)/pkg_built.rpm.$(DIST): $(SOURCE_ARCHIVE) $(RPM_ARCHIVE) $(RPM_SPEC) $(RPM_CONTENT_OUT)
	@rpmbuild -ba $(RPMBUILD_OPTIONS) $(BUILD_DIR)/rpm.$(DIST)/SPEC/$(PKGNAME).spec
	@find $(BUILD_DIR)/rpm.$(DIST) -type f -name "*.src.rpm" -print0 | xargs -0 -r mv -t $(OUT_SRC)/
	@find $(BUILD_DIR)/rpm.$(DIST) -type f -name "*.rpm" -print0 | xargs -0 -r mv -t $(OUT_DIR)/
	@touch $@

# Build source RPM packages
$(BUILD_DIR)/pkg_built.src.rpm.$(DIST): $(SOURCE_ARCHIVE) $(RPM_ARCHIVE) $(RPM_SPEC) $(RPM_CONTENT_OUT)
	@rpmbuild -bs $(RPMBUILD_OPTIONS) $(BUILD_DIR)/rpm.$(DIST)/SPEC/$(PKGNAME).spec
	@touch $@

# Build RPM packages in a clean chroot environment using mock
$(BUILD_DIR)/pkg_built_chroot.rpm.$(DIST): $(BUILD_DIR)/pkg_built.src.rpm.$(DIST)
	@$(MOCK_CMD); \
	if [ $$? -ne 0 ]; then \
		touch $(BUILD_DIR)/failure.rpm.chroot.$(DIST); \
		exit 1; \
	else \
		rm -f $(BUILD_DIR)/failure.rpm.chroot.$(DIST); \
	fi
	@find $(INDIVIDUAL_RPM_LOCAL_REPO_PATH)/results/$(DIST_FULL)-$(ARCH)/$$(rpm -qp $(CURDIR)/$(BUILD_DIR)/rpm.$(DIST)/SRPMS/*$(VERSION)-$(RELEASE)*.rpm \
		--queryformat "%{NAME}-%{VERSION}-%{RELEASE}") \
		-type f -name "*$(DIST)*$(ARCH)*.rpm" \
		-not -name "*.src.rpm" -print0 | \
		xargs -0 -r ln -f -t $(OUT_DIR)/
	@find $(INDIVIDUAL_RPM_LOCAL_REPO_PATH)/results/$(DIST_FULL)-$(ARCH)/$$(rpm -qp $(CURDIR)/$(BUILD_DIR)/rpm.$(DIST)/SRPMS/*$(VERSION)-$(RELEASE)*.rpm \
		--queryformat "%{NAME}-%{VERSION}-%{RELEASE}") \
		-type f -name  "*$(DIST)*noarch*.rpm" \
		-not -name "*.src.rpm" -print0 | \
		xargs -0 -r ln -f -t $(OUT_DIR)/
	@touch $@
	@touch $(BUILD_DIR)/pkg_built.src.rpm.$(DIST).internal

rpm_shell_chroot:
	@-$(MAKE) rpm_chroot MOCK_BUILD_ADDITIONAL_ARGS="$(MOCK_BUILD_ADDITIONAL_ARGS) --no-cleanup-after"
	@-$(MOCK_COMMON) --install dnf vim tree
	@-$(MOCK_COMMON) --cwd=/builddir/build/ --shell /bin/bash
	@-$(MOCK_COMMON) --clean

# Conditional targets based on the TO_SKIP variable
ifneq ($(TO_SKIP), true)
rpm_src_internal: $(BUILD_DIR)/pkg_built.src.rpm.$(DIST).internal

$(BUILD_DIR)/pkg_built.src.rpm.$(DIST).internal: $(BUILD_DIR)/pkg_built.src.rpm.$(DIST)

rpm_chroot: $(BUILD_DIR)/pkg_built_chroot.rpm.$(DIST)

# Main RPM build target
rpm: $(BUILD_DIR)/pkg_built.rpm.$(DIST)
else
rpm:
rpm_chroot:
endif
