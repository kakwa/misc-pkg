# Name of the package
NAME = cosmic-epoch

# Version
VERSION = 1.0.4

# Revision number 
RELEASE = 1

# URL of the project 
URL=https://github.com/pop-os/cosmic-epoch

# short summary of what the package provides
SUMMARY=COSMIC Desktop Environment - Next generation desktop for Pop!_OS

# Long version of the summary
DESCRIPTION=COSMIC is a desktop environment offering performance, efficiency, and personalization to empower a wide variety of use cases.

# License of the upstream project
LICENSE=GPL-3.0

# Distribution versions to skip
SKIP=<=:deb:11 <=:ubu:22.04

# Allow network inside chroot/mock for building Rust
COWBUILD_BUILD_ADDITIONAL_ARGS=--use-network yes
MOCK_BUILD_ADDITIONAL_ARGS=--enable-network

###############################################################################
# Rule #
########

# Main upstream tag
UPSTREAM_TAG=epoch-$(VERSION)

# URLs for all submodules
URL_COSMIC_APPLETS=https://github.com/pop-os/cosmic-applets/archive/d4f62852f3fdaf3b7f1c4a5fa87724d0314467b0.tar.gz
URL_COSMIC_APPLIBRARY=https://github.com/pop-os/cosmic-applibrary/archive/22926ea0acc3f601924e58156a9be6a488060f13.tar.gz
URL_COSMIC_BG=https://github.com/pop-os/cosmic-bg/archive/0b8ecbd4b4e258ddf12ee9affa0fa9f8d1297dfe.tar.gz
URL_COSMIC_COMP=https://github.com/pop-os/cosmic-comp/archive/1dfc948f1ebf2995fcbf9efe570103f9a46cf7e4.tar.gz
URL_COSMIC_EDIT=https://github.com/pop-os/cosmic-edit/archive/6dbc5d5ef7ea26adb250fcd2b268bb727f29af36.tar.gz
URL_COSMIC_FILES=https://github.com/pop-os/cosmic-files/archive/3e932877a97b57367c58f0ebf9805dd6f9dc5981.tar.gz
URL_COSMIC_GREETER=https://github.com/pop-os/cosmic-greeter/archive/a5dcdb42c4a55e1b438865bf699005be8637b08b.tar.gz
URL_COSMIC_ICONS=https://github.com/pop-os/cosmic-icons/archive/cd30ffd509bb6b289ac5d8ae26e2e30341e9b8cb.tar.gz
URL_COSMIC_IDLE=https://github.com/pop-os/cosmic-idle/archive/6d3dbedd50b45e0d05a565b35e89c6dbf508bf22.tar.gz
URL_COSMIC_INITIAL_SETUP=https://github.com/pop-os/cosmic-initial-setup/archive/9f2a68d2cc870f647ef5eeb818f1a21da4e2cb44.tar.gz
URL_COSMIC_LAUNCHER=https://github.com/pop-os/cosmic-launcher/archive/2941ad16b634ce4c9fda692bbec33a6e92b53006.tar.gz
URL_COSMIC_NOTIFICATIONS=https://github.com/pop-os/cosmic-notifications/archive/970b7672cae313c1934edd922e3271e8ae651f9b.tar.gz
URL_COSMIC_OSD=https://github.com/pop-os/cosmic-osd/archive/5252e8e94ef931858166bb7a9dc4040c46de9f06.tar.gz
URL_COSMIC_PANEL=https://github.com/pop-os/cosmic-panel/archive/8eb8a1b6305213ec7402cb2ec24bef6b501b978a.tar.gz
URL_COSMIC_PLAYER=https://github.com/pop-os/cosmic-player/archive/9d5654cd8e95fb7819a9babb34861f029d0c0a50.tar.gz
URL_COSMIC_RANDR=https://github.com/pop-os/cosmic-randr/archive/741089cf5e3aa7d5e48042101c1d4cc813b13637.tar.gz
URL_COSMIC_SCREENSHOT=https://github.com/pop-os/cosmic-screenshot/archive/b550b45da3fade3d1d2a018677be078bd7e7e6e9.tar.gz
URL_COSMIC_SESSION=https://github.com/pop-os/cosmic-session/archive/3506cfc404222acab080a0bfd7f28a978eb71372.tar.gz
URL_COSMIC_SETTINGS=https://github.com/pop-os/cosmic-settings/archive/eec172cdae62cf8b937346113521e5c5a5677580.tar.gz
URL_COSMIC_SETTINGS_DAEMON=https://github.com/pop-os/cosmic-settings-daemon/archive/ef024bfd06bf9fbd57246a25c91d1fdd28153d05.tar.gz
URL_COSMIC_STORE=https://github.com/pop-os/cosmic-store/archive/838aa844dcc0d517d8ef8f1c5f77afb162c455a2.tar.gz
URL_COSMIC_TERM=https://github.com/pop-os/cosmic-term/archive/cdeaeeddc930ae9e2901377e6faf414c2767bc13.tar.gz
URL_COSMIC_WALLPAPERS=https://github.com/pop-os/cosmic-wallpapers/archive/189c2c63d31da84ebb161acfd21a503f98a1b4c7.tar.gz
URL_COSMIC_WORKSPACES=https://github.com/pop-os/cosmic-workspaces-epoch/archive/e50554cdffc3d3130eb0c05c4be03797fd017dea.tar.gz
URL_XDG_PORTAL=https://github.com/pop-os/xdg-desktop-portal-cosmic/archive/2ab83d5053dca735be56304493b8cb2dde462a42.tar.gz
URL_POP_LAUNCHER=https://github.com/pop-os/launcher/archive/eead361cca44d8e19e988572462c49e26cf20427.tar.gz

# Main source URL
URL_SRC=$(URL)/archive/refs/tags/$(UPSTREAM_TAG).tar.gz

# Including common rules and targets 
include buildenv/Makefile.common

# preparation hook for sources
#
# use 'make manifest' to generate/update this manifest file.
$(SOURCE_ARCHIVE): $(SOURCE_DIR) $(CACHE) Makefile MANIFEST
	@echo "Downloading main source..."
	@$(WGS) -u $(URL_SRC) -O $(NAME)-$(VERSION).tar.gz
	@tar -xf $(CACHE_DIR)/$(NAME)-$(VERSION).tar.gz -C $(SOURCE_DIR) --strip-components=1
	
	@echo "Downloading submodules..."
	@$(WGS) -u $(URL_COSMIC_APPLETS) -O cosmic-applets.tar.gz
	@mkdir -p $(SOURCE_DIR)/cosmic-applets
	@tar -xf $(CACHE_DIR)/cosmic-applets.tar.gz -C $(SOURCE_DIR)/cosmic-applets --strip-components=1
	
	@$(WGS) -u $(URL_COSMIC_APPLIBRARY) -O cosmic-applibrary.tar.gz
	@mkdir -p $(SOURCE_DIR)/cosmic-applibrary
	@tar -xf $(CACHE_DIR)/cosmic-applibrary.tar.gz -C $(SOURCE_DIR)/cosmic-applibrary --strip-components=1
	
	@$(WGS) -u $(URL_COSMIC_BG) -O cosmic-bg.tar.gz
	@mkdir -p $(SOURCE_DIR)/cosmic-bg
	@tar -xf $(CACHE_DIR)/cosmic-bg.tar.gz -C $(SOURCE_DIR)/cosmic-bg --strip-components=1
	
	@$(WGS) -u $(URL_COSMIC_COMP) -O cosmic-comp.tar.gz
	@mkdir -p $(SOURCE_DIR)/cosmic-comp
	@tar -xf $(CACHE_DIR)/cosmic-comp.tar.gz -C $(SOURCE_DIR)/cosmic-comp --strip-components=1
	
	@$(WGS) -u $(URL_COSMIC_EDIT) -O cosmic-edit.tar.gz
	@mkdir -p $(SOURCE_DIR)/cosmic-edit
	@tar -xf $(CACHE_DIR)/cosmic-edit.tar.gz -C $(SOURCE_DIR)/cosmic-edit --strip-components=1
	
	@$(WGS) -u $(URL_COSMIC_FILES) -O cosmic-files.tar.gz
	@mkdir -p $(SOURCE_DIR)/cosmic-files
	@tar -xf $(CACHE_DIR)/cosmic-files.tar.gz -C $(SOURCE_DIR)/cosmic-files --strip-components=1
	
	@$(WGS) -u $(URL_COSMIC_GREETER) -O cosmic-greeter.tar.gz
	@mkdir -p $(SOURCE_DIR)/cosmic-greeter
	@tar -xf $(CACHE_DIR)/cosmic-greeter.tar.gz -C $(SOURCE_DIR)/cosmic-greeter --strip-components=1
	
	@$(WGS) -u $(URL_COSMIC_ICONS) -O cosmic-icons.tar.gz
	@mkdir -p $(SOURCE_DIR)/cosmic-icons
	@tar -xf $(CACHE_DIR)/cosmic-icons.tar.gz -C $(SOURCE_DIR)/cosmic-icons --strip-components=1
	
	@$(WGS) -u $(URL_COSMIC_IDLE) -O cosmic-idle.tar.gz
	@mkdir -p $(SOURCE_DIR)/cosmic-idle
	@tar -xf $(CACHE_DIR)/cosmic-idle.tar.gz -C $(SOURCE_DIR)/cosmic-idle --strip-components=1
	
	@$(WGS) -u $(URL_COSMIC_INITIAL_SETUP) -O cosmic-initial-setup.tar.gz
	@mkdir -p $(SOURCE_DIR)/cosmic-initial-setup
	@tar -xf $(CACHE_DIR)/cosmic-initial-setup.tar.gz -C $(SOURCE_DIR)/cosmic-initial-setup --strip-components=1
	
	@$(WGS) -u $(URL_COSMIC_LAUNCHER) -O cosmic-launcher.tar.gz
	@mkdir -p $(SOURCE_DIR)/cosmic-launcher
	@tar -xf $(CACHE_DIR)/cosmic-launcher.tar.gz -C $(SOURCE_DIR)/cosmic-launcher --strip-components=1
	
	@$(WGS) -u $(URL_COSMIC_NOTIFICATIONS) -O cosmic-notifications.tar.gz
	@mkdir -p $(SOURCE_DIR)/cosmic-notifications
	@tar -xf $(CACHE_DIR)/cosmic-notifications.tar.gz -C $(SOURCE_DIR)/cosmic-notifications --strip-components=1
	
	@$(WGS) -u $(URL_COSMIC_OSD) -O cosmic-osd.tar.gz
	@mkdir -p $(SOURCE_DIR)/cosmic-osd
	@tar -xf $(CACHE_DIR)/cosmic-osd.tar.gz -C $(SOURCE_DIR)/cosmic-osd --strip-components=1
	
	@$(WGS) -u $(URL_COSMIC_PANEL) -O cosmic-panel.tar.gz
	@mkdir -p $(SOURCE_DIR)/cosmic-panel
	@tar -xf $(CACHE_DIR)/cosmic-panel.tar.gz -C $(SOURCE_DIR)/cosmic-panel --strip-components=1
	
	@$(WGS) -u $(URL_COSMIC_PLAYER) -O cosmic-player.tar.gz
	@mkdir -p $(SOURCE_DIR)/cosmic-player
	@tar -xf $(CACHE_DIR)/cosmic-player.tar.gz -C $(SOURCE_DIR)/cosmic-player --strip-components=1
	
	@$(WGS) -u $(URL_COSMIC_RANDR) -O cosmic-randr.tar.gz
	@mkdir -p $(SOURCE_DIR)/cosmic-randr
	@tar -xf $(CACHE_DIR)/cosmic-randr.tar.gz -C $(SOURCE_DIR)/cosmic-randr --strip-components=1
	
	@$(WGS) -u $(URL_COSMIC_SCREENSHOT) -O cosmic-screenshot.tar.gz
	@mkdir -p $(SOURCE_DIR)/cosmic-screenshot
	@tar -xf $(CACHE_DIR)/cosmic-screenshot.tar.gz -C $(SOURCE_DIR)/cosmic-screenshot --strip-components=1
	
	@$(WGS) -u $(URL_COSMIC_SESSION) -O cosmic-session.tar.gz
	@mkdir -p $(SOURCE_DIR)/cosmic-session
	@tar -xf $(CACHE_DIR)/cosmic-session.tar.gz -C $(SOURCE_DIR)/cosmic-session --strip-components=1
	
	@$(WGS) -u $(URL_COSMIC_SETTINGS) -O cosmic-settings.tar.gz
	@mkdir -p $(SOURCE_DIR)/cosmic-settings
	@tar -xf $(CACHE_DIR)/cosmic-settings.tar.gz -C $(SOURCE_DIR)/cosmic-settings --strip-components=1
	
	@$(WGS) -u $(URL_COSMIC_SETTINGS_DAEMON) -O cosmic-settings-daemon.tar.gz
	@mkdir -p $(SOURCE_DIR)/cosmic-settings-daemon
	@tar -xf $(CACHE_DIR)/cosmic-settings-daemon.tar.gz -C $(SOURCE_DIR)/cosmic-settings-daemon --strip-components=1
	
	@$(WGS) -u $(URL_COSMIC_STORE) -O cosmic-store.tar.gz
	@mkdir -p $(SOURCE_DIR)/cosmic-store
	@tar -xf $(CACHE_DIR)/cosmic-store.tar.gz -C $(SOURCE_DIR)/cosmic-store --strip-components=1
	
	@$(WGS) -u $(URL_COSMIC_TERM) -O cosmic-term.tar.gz
	@mkdir -p $(SOURCE_DIR)/cosmic-term
	@tar -xf $(CACHE_DIR)/cosmic-term.tar.gz -C $(SOURCE_DIR)/cosmic-term --strip-components=1
	
	@$(WGS) -u $(URL_COSMIC_WALLPAPERS) -O cosmic-wallpapers.tar.gz
	@mkdir -p $(SOURCE_DIR)/cosmic-wallpapers
	@tar -xf $(CACHE_DIR)/cosmic-wallpapers.tar.gz -C $(SOURCE_DIR)/cosmic-wallpapers --strip-components=1
	
	@$(WGS) -u $(URL_COSMIC_WORKSPACES) -O cosmic-workspaces-epoch.tar.gz
	@mkdir -p $(SOURCE_DIR)/cosmic-workspaces-epoch
	@tar -xf $(CACHE_DIR)/cosmic-workspaces-epoch.tar.gz -C $(SOURCE_DIR)/cosmic-workspaces-epoch --strip-components=1
	
	@$(WGS) -u $(URL_XDG_PORTAL) -O xdg-desktop-portal-cosmic.tar.gz
	@mkdir -p $(SOURCE_DIR)/xdg-desktop-portal-cosmic
	@tar -xf $(CACHE_DIR)/xdg-desktop-portal-cosmic.tar.gz -C $(SOURCE_DIR)/xdg-desktop-portal-cosmic --strip-components=1
	
	@$(WGS) -u $(URL_POP_LAUNCHER) -O pop-launcher.tar.gz
	@mkdir -p $(SOURCE_DIR)/pop-launcher
	@tar -xf $(CACHE_DIR)/pop-launcher.tar.gz -C $(SOURCE_DIR)/pop-launcher --strip-components=1
	
	@echo "Removing git metadata..."
	@rm -rf $(SOURCE_DIR)/.git $(SOURCE_DIR)/.gitmodules $(SOURCE_DIR)/.gitignore
	@find $(SOURCE_DIR) -name ".git" -type d -exec rm -rf {} + 2>/dev/null || true
	@find $(SOURCE_DIR) -name ".gitignore" -delete 2>/dev/null || true
	
	@echo "Creating source tarball..."
	@$(SOURCE_TAR_CMD)
