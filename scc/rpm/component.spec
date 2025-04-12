%define pkgname @NAME@

%global debug_package %{nil}

Name: %{pkgname}
Version: @VERSION@
Release: @RELEASE@%{?dist}

Source: %{pkgname}-%{version}.tar.gz

URL: @URL@
Vendor: @MAINTAINER@
License: @LICENSE@
Group: System/Servers
Summary: @SUMMARY@
BuildRoot: %{_tmppath}/%{pkgname}-%{version}-%{release}-build
BuildRequires: golang >= 1.21
BuildRequires: systemd-rpm-macros
BuildRequires: make
Requires: systemd

%description
@DESCRIPTION@

%prep
%setup -q -n %{pkgname}-%{version}

%build
export GOPROXY=proxy.golang.org
export GOSUMDB=sum.golang.org
export GO111MODULE=on
export GOTOOLCHAIN=auto
go build -ldflags="-s -w" -o scc

%install
rm -rf $RPM_BUILD_ROOT
mkdir -p %{buildroot}%{_bindir}

install -m 755 scc %{buildroot}%{_bindir}/

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-, root, root, -)
%{_bindir}/scc

%changelog
* Sat Mar 15 2025 @MAINTAINER@ <@MAINTAINER_EMAIL@> 0.0.1-1
- initial Version initiale
