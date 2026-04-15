%define pkgname @NAME@

%global debug_package %{nil}

Name: %{pkgname}
Version: @VERSION@
Release: @RELEASE@%{?dist}
Source: %{pkgname}-%{version}.tar.gz
Source1: docker-registry.config.yml
Source2: docker-registry.service

URL: @URL@
Vendor: @MAINTAINER@
License: Apache-2.0
Group: Applications/Internet
Summary: @SUMMARY@
BuildRoot: %{_tmppath}/%{pkgname}-%{_build_arch}-%{version}-%{release}-build

BuildRequires: golang >= 1.22
BuildRequires: systemd-rpm-macros
Requires(post): systemd

%description
@DESCRIPTION@

%prep
%setup -q -n %{pkgname}-%{version}

%build
export GOPROXY=https://proxy.golang.org
export GOSUMDB=sum.golang.org
export GO111MODULE=on
export CGO_ENABLED=0
mkdir -p bin
GOTOOLCHAIN=auto go build -buildmode=pie -trimpath \
	-ldflags "-extldflags=-Wl,-z,now -s -w -X github.com/distribution/distribution/v3/version.version=v%{version} -X github.com/distribution/distribution/v3/version.revision=rpm -X github.com/distribution/distribution/v3/version.mainpkg=github.com/distribution/distribution/v3" \
	-o bin/registry ./cmd/registry

%install
rm -rf %{buildroot}
mkdir -p %{buildroot}%{_bindir}
install -m 755 bin/registry %{buildroot}%{_bindir}/registry
mkdir -p %{buildroot}%{_sysconfdir}/docker/registry
install -m 644 %{SOURCE1} %{buildroot}%{_sysconfdir}/docker/registry/config.yml
mkdir -p %{buildroot}%{_unitdir}
install -m 644 %{SOURCE2} %{buildroot}%{_unitdir}/docker-registry.service
mkdir -p %{buildroot}%{_docdir}/%{name}-%{version}/examples
install -m 644 cmd/registry/config-example.yml cmd/registry/config-dev.yml cmd/registry/config-cache.yml \
	%{buildroot}%{_docdir}/%{name}-%{version}/examples/

%post
getent passwd registry >/dev/null || \
	useradd -r -d /var/lib/registry -s /sbin/nologin -c "OCI registry" registry
mkdir -p /var/lib/registry
chown registry:registry /var/lib/registry
chmod 0750 /var/lib/registry
%systemd_post docker-registry.service

%preun
%systemd_preun docker-registry.service

%postun
%systemd_postun docker-registry.service

%clean
rm -rf %{buildroot}

%files
%{_bindir}/registry
%config(noreplace) %{_sysconfdir}/docker/registry/config.yml
%{_unitdir}/docker-registry.service
%{_docdir}/%{name}-%{version}/examples/config-example.yml
%{_docdir}/%{name}-%{version}/examples/config-dev.yml
%{_docdir}/%{name}-%{version}/examples/config-cache.yml

%changelog
* Tue Apr 15 2026 @MAINTAINER@ <@MAINTAINER_EMAIL@> 3.1.0-1
- Package Distribution registry 3.1.0 (built from source).
