%define pkgname @NAME@

%global debug_package %{nil}

Name: %{pkgname}
Version: @VERSION@
Release: @RELEASE@%{?dist}

Source: %{pkgname}-%{version}.tar.gz

URL: @URL@
Vendor: @MAINTAINER@
License: @LICENSE@
Group: Development/Tools
Summary: @SUMMARY@
BuildRoot: %{_tmppath}/%{pkgname}-%{version}-%{release}-build

BuildRequires: python3-devel
BuildRequires: python3-setuptools
BuildRequires: python3-pip
BuildRequires: systemd-rpm-macros
BuildRequires: make

Requires: python3
Requires: python3-ajsonrpc
Requires: python3-bottle
Requires: python3-click
Requires: python3-colorama
Requires: python3-marshmallow
Requires: python3-pyelftools
Requires: python3-pyserial
Requires: python3-requests
Requires: python3-semantic-version
Requires: python3-starlette
Requires: python3-tabulate
Requires: python3-wsproto
Requires: python3-zeroconf
Requires: python3-uvicorn

%description
@DESCRIPTION@

%prep
%setup -q -n %{pkgname}-%{version}

%build
%py3_build

%install
rm -rf $RPM_BUILD_ROOT
%py3_install

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-, root, root, -)
%{python3_sitelib}/*
%{_bindir}/pio
%{_bindir}/piodebuggdb

%changelog
* Fri Jan 23 2026 @MAINTAINER@ <@MAINTAINER_EMAIL@> 6.1.18-1
- Initial version 6.1.18
