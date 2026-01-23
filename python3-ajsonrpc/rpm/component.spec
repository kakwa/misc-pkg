%define pkgname @NAME@
%define pypi_name ajsonrpc

%global debug_package %{nil}

Name: %{pkgname}
Version: @VERSION@
Release: @RELEASE@%{?dist}
Source: %{pkgname}-%{version}.tar.gz

URL: @URL@ 
Vendor: @MAINTAINER@
License: @LICENSE@
Group: Development/Libraries
Summary: @SUMMARY@ 
BuildRoot: %{_tmppath}/%{pkgname}-%{version}-%{release}-build
BuildArch: noarch

# Build Dependencies
BuildRequires: python3-devel
BuildRequires: python3-setuptools

# Runtime Dependencies
Requires: python3


%description
@DESCRIPTION@

%prep
%setup -q -n %{pkgname}-%{version}

%build
%{__python3} setup.py build

%install
rm -rf -- $RPM_BUILD_ROOT
%{__python3} setup.py install --skip-build --root $RPM_BUILD_ROOT

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root,-)
%{python3_sitelib}/%{pypi_name}/
%{python3_sitelib}/%{pypi_name}-*.egg-info/
%{_bindir}/async-json-rpc-server
%license LICENSE.txt
%doc README.md

%changelog
* Fri Jan 23 2026 @MAINTAINER@ <@MAINTAINER_EMAIL@> 1.2.0-1
- Initial packaging of ajsonrpc 1.2.0
