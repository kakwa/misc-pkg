%define pkgname @NAME@

%global debug_package %{nil}

Name: %{pkgname}
Version: @VERSION@
Release: @RELEASE@%{?dist}
Source: %{pkgname}-%{version}.tar.gz

URL: @URL@
Vendor: @MAINTAINER@
License: MPL-2.0
Group: System Administration/Kubernetes
Summary: @SUMMARY@
BuildRoot: %{_tmppath}/%{pkgname}-%{_build_arch}-%{version}-%{release}-build

BuildRequires: golang >= 1.22

%description
@DESCRIPTION@

%prep
%setup -q -n %{pkgname}-%{version}

%build
export GOPROXY=https://proxy.golang.org
export GOSUMDB=sum.golang.org
export GO111MODULE=on
export CGO_ENABLED=0
GOTOOLCHAIN=auto go build -ldflags="-s -w" -tags "grpcnotrace" -o talosctl ./cmd/talosctl

%install
rm -rf %{buildroot}
mkdir -p %{buildroot}%{_bindir}
install -m 755 talosctl %{buildroot}%{_bindir}/talosctl

%clean
rm -rf %{buildroot}

%files
%{_bindir}/talosctl

%changelog
* Fri Feb 06 2026 @MAINTAINER@ <@MAINTAINER_EMAIL@> 1.12.2-1
- Package talosctl 1.12.2 from Sidero Labs Talos (built from source).
