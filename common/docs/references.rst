Reference
=========

Projects Using Pakste
---------------------

Here are a few projects using Pakste:

* `Debian/Ubuntu packaging for RPM/Mock <https://github.com/kakwa/debian-rpm-build-tools>`_ (itself a Pakste dependency).
* `Misc Open Feature Flag packages <https://github.com/funwithfeatureflags/fffpkg>`_.
* `Packages for Author's projects <https://github.com/kakwa/kakwalab-pkg>`_.
* `Misc Packages from upstream projects <https://github.com/kakwa/misc-pkg>`_.

Makefile Targets
----------------

Miscellaneous Targets
~~~~~~~~~~~~~~~~~~~~~

.. list-table::
   :header-rows: 1
   :widths: 20 15 65

   * - Target
     - Level
     - Description
   * - ``help``
     - package & repo/root
     - Display available targets and their descriptions
   * - ``clean``
     - package & repo/root
     - Remove all build artifacts and directories
   * - ``vulncheck``
     - package & repo/root
     - Check NVD public vulnerabilities
   * - ``github_matrix``
     - repo/root
     - Output the Github Action Matrix (json)

.. list-table::
   :header-rows: 1
   :widths: 20 15 65

   * - Variable
     - Default
     - Description
   * - ``KEEP_CACHE`` (clean target only)
     - ``false``
     - When set to ``true``, keeps downloaded sources during clean

Package Building Targets
~~~~~~~~~~~~~~~~~~~~~~~~

.. list-table::
   :header-rows: 1
   :widths: 20 15 65

   * - Target
     - Level
     - Description
   * - ``manifest``
     - package
     - Create or update the MANIFEST file with source archive checksums
   * - ``deb``
     - package
     - Build DEB package locally (requires build dependencies)
   * - ``rpm``
     - package
     - Build RPM package locally (requires build dependencies)
   * - ``deb_chroot``
     - package & repo/root
     - Build DEB package in a clean chroot environment
   * - ``rpm_chroot``
     - package & repo/root
     - Build RPM package in a clean chroot environment
   * - ``deb_shell_chroot``
     - package
     - Debug, try to build DEB package and spawn a shell if error
   * - ``rpm_shell_chroot``
     - package
     - Debug, try to build RPM package and spawn a shell if error


.. list-table::
   :header-rows: 1
   :widths: 20 15 65

   * - Variable
     - Default
     - Description
   * - ``DIST``
     - *none*
     - Target distribution codename (e.g., bullseye, el9)
   * - ``ARCH``
     - host architecture
     - Target Architecture (e.g., arm64, riscv64, amd64)

Repository Targets
~~~~~~~~~~~~~~~~~~

.. list-table::
   :header-rows: 1
   :widths: 20 15 65

   * - Target
     - Level
     - Description
   * - ``deb_repo``
     - repo/root
     - Build .deb repository for a specific distribution & architecture
   * - ``rpm_repo``
     - repo/root
     - Build .rpm repository for a specific distribution & architecture
   * - ``rpm_all_repos``
     - repo/root
     - Build all .rpm repositories for all targets (see RPM_ALL_TARGETS in Makefile.config)
   * - ``deb_all_repos``
     - repo/root
     - Build all .deb repositories for all targets (see DEB_ALL_TARGETS in Makefile.config)
   * - ``all_repos``
     - repo/root
     - Build all .deb and .rpm repositories for all targets (default target)


.. list-table::
   :header-rows: 1
   :widths: 20 15 65

   * - Variable
     - Default
     - Description
   * - ``DIST``
     - *none*
     - Target distribution codename (e.g., bullseye, el9)
   * - ``ARCH``
     - host architecture
     - Target Architecture (e.g., arm64, riscv64, amd64)
   * - ``ERROR``
     - *none*
     - Set to ``skip`` to continue building repos despite package failures

Package Initialization Tool
---------------------------

Initialize a new package:

.. sourcecode:: bash

    ./common/init_pkg.sh -n <PKG_NAME>


Makefile Helper Variables
-------------------------

These variables are defined in the build environment and are commonly used in package building:

.. list-table::
   :header-rows: 1
   :widths: 20 15 65

   * - Variable
     - Default
     - Description
   * - ``WGS``
     - *none*
     - Helper command for wget-based source recovery and manifest generation. Uses wget_sum.sh with manifest and cache directory configuration.
   * - ``GS``
     - *none*
     - Helper command for git-based source recovery and manifest generation. Uses git_sum.sh with manifest and cache directory configuration.
   * - ``SOURCE_DIR``
     - ``$(BUILD_DIR)/$(PKGNAME)-$(VERSION)``
     - Directory where source files are extracted during the build process.
   * - ``SOURCE_ARCHIVE``
     - ``$(BUILD_DIR)/$(PKGNAME)_$(VERSION).orig.tar.gz``
     - Path to the source archive file that will be created during the build process.

Source Recovery Helpers Arguments
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The source recovery helpers (``WGS`` and ``GS``) expose the following arguments to users:

.. list-table::
   :header-rows: 1
   :widths: 20 15 65

   * - Argument
     - Required
     - Description
   * - ``-u <url>``
     - Yes
     - URL of the source to download
   * - ``-o <outfile>``
     - Yes
     - Path to output file (alternative to -O)
   * - ``-O <outfile>``
     - Yes
     - Path to output file (alternative to -o)
   * - ``-t <tag>``
     - No
     - Git tag to check out (for ``GS`` only)
   * - ``-r <revision>``
     - No
     - Git revision (commit hash) to check out (for ``GS`` only)
   * - ``-s``
     - No
     - Initialize and update Git submodules (for ``GS`` only)

Examples
~~~~~~~~

Basic Recovery:

.. sourcecode:: make

   $(SOURCE_ARCHIVE): $(CACHE) Makefile MANIFEST | $(SOURCE_DIR)
       $(WGS) -u $(URL_SRC) -o $(BUILD_DIR)/$(NAME)-$(VERSION).tar.gz

Recovery + Clean-up (upstream `debian/` dir removal):

.. sourcecode::

   $(SOURCE_ARCHIVE): $(CACHE) Makefile MANIFEST | $(SOURCE_DIR)
       @$(WGS) -u $(URL_SRC) -O $(NAME)-$(VERSION).tar.gz
       @tar -vxf $(CACHE_DIR)/$(NAME)-$(VERSION).tar.gz -C $(SOURCE_DIR) --strip-components=1
       @rm -rf -- $(SOURCE_DIR)/debian
       @$(SOURCE_TAR_CMD)

Pakste Common Commands
----------------------

In a package directory:

.. sourcecode:: bash

    # Build a DEB package in a chroot for Debian Trixie & arm64
    make deb_chroot DIST=trixie ARCH=arm64

    # Build an RPM package in a chroot for RHEL 9
    make rpm_chroot DIST=el9

At the root of the repository:

.. sourcecode:: bash

    # Build a complete DEB repository with parallel jobs
    make deb_repo -j4 DIST=bullseye

    # Build a complete RPM repository, continuing on errors
    make rpm_repo DIST=el9 ERROR=skip

    # Build every deb targets
    make deb_all_repos -j4

    # Build every rpm targets
    make rpm_all_repos -j4

    # Build everything
    make -j4

    # Clean but keep downloaded sources
    make clean KEEP_CACHE=true

Internal Scripts
----------------

Version comparator utility:

.. sourcecode:: bash

   # help
   ./common/buildenv/compare_version.sh -h

   # example
   ./common/buildenv/compare_version.sh -v 1.0 -o '>' -V 0.9
    
Distribution metadata recovery utility:

.. sourcecode:: bash

   # help
   ./common/buildenv/get_dist.sh -h

   # example
   ./common/buildenv/get_dist.sh ubu22.04

Git Source Recovery & Manifest tool:

.. sourcecode:: bash

   # help
   ./common/buildenv/git_sum.sh -h

   # example
   ./common/buildenv/git_sum.sh -m ./MANIFEST \
       -C "./cache/" \
       -u https://github.com/Spotifyd/spotifyd/ \
       -t v0.4.0 \
       -o ./spotifyd_0.4.0.orig.tar.gz \
       -c # update Manifest

Wget based source recovery & manifest generation utility:

.. sourcecode:: bash

   # help
   ./common/buildenv/wget_sum.sh -h

   # example
   ./common/buildenv/wget_sum.sh -m ./MANIFEST \
       -C "./cache/" \
       -u https://github.com/Spotifyd/spotifyd/archive/refs/tags/v0.4.1.tar.gz \
       -o ./spotifyd_0.4.1.orig.tar.gz \
       -c # update manifest

Tool to check a given distribution against an ignore expression:

.. sourcecode:: bash

   # help
   ./common/buildenv/skip_flag.sh -h

   # example:
   ./common/buildenv/skip_flag.sh -i '=:el:6 <:deb:8' -d deb -v 7
