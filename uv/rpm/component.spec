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
BuildRoot: %{_tmppath}/%{pkgname}-%{zone}-%{version}-%{release}-build
BuildRequires: systemd-rpm-macros
BuildRequires: rust
BuildRequires: cargo
BuildRequires: openssl-devel
BuildRequires: pkgconfig

%description
@DESCRIPTION@

%prep

%setup -q -n %{pkgname}-%{version}

%build
cargo build --release --package uv

%install

rm -rf -- $RPM_BUILD_ROOT
mkdir -p %{buildroot}%{_bindir}
install -m 755 target/release/uv %{buildroot}%{_bindir}/uv
if [ -f target/release/uvx ]; then
    install -m 755 target/release/uvx %{buildroot}%{_bindir}/uvx
else
    ln -s uv %{buildroot}%{_bindir}/uvx
fi


%post
true


%preun
true


%postun
true

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(644, root, root, 755)
%attr(755, root, root) %{_bindir}/uv
%{_bindir}/uvx


%changelog
* Sun Jun 08 2025 @MAINTAINER@ <@MAINTAINER_EMAIL@> 0.11.19-1
- initial Version
