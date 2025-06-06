# Some distributions name their Freetype 2 package "freetype", while others
# name it "freetype2".  You can define the name your distribution uses here.
%define freetype2 freetype

Summary:	Font configuration and customization library
Name:		fontconfig
Version:	2.2.0
Release:	1
License:	MIT
Group:		System Environment/Libraries
Source:		http://fontconfig.org/release/fontconfig-%{version}.tar.gz
URL:            http://fontconfig.org
BuildRoot:	%{_tmppath}/%{name}-%{version}-root

BuildRequires: %{_bindir}/docbook2html
BuildRequires: %{_bindir}/docbook2txt
BuildRequires: %{freetype2}-devel
BuildRequires: expat-devel
BuildRequires: perl

PreReq: %{freetype2}

%description
Fontconfig is designed to locate fonts within the
system and select them according to requirements specified by 
applications.

%package devel
Summary:	Font configuration and customization library
Group:		Development/Libraries
Requires:	%{name} = %{version}
Requires:	%{freetype2}-devel

%description devel
The fontconfig-devel package includes the static libraries, 
header files, and developer docs for the fontconfig package.

Install fontconfig-devel if you want to develop programs which 
will use fontconfig.

%prep
%setup -q

%build
%configure --with-x-fonts=/usr/X11R6/lib/X11/fonts --disable-gtk-doc --disable-docs
make %{_smp_mflags}

%install
[ "$RPM_BUILD_ROOT" != "/" ] && rm -rf $RPM_BUILD_ROOT
{
  %makeinstall
  # fontconfig is currently installing these in improper location for RPM
  # based Linux distributions, so we remove what it installs here, and let
  # RPM pick up the same files with 'doc' directives in the file lists as
  # a workaround
  rm -rf $RPM_BUILD_ROOT/%{_datadir}/doc/fontconfig
}

%clean
[ "$RPM_BUILD_ROOT" != "/" ] && rm -rf $RPM_BUILD_ROOT

%post
{
  /sbin/ldconfig
  # Force regeneration of all fontconfig cache files.
  %{_bindir}/fc-cache -f --system-only
}

%postun -p /sbin/ldconfig

%files
%defattr(-, root, root)
%doc README AUTHORS COPYING ChangeLog doc/fontconfig-*.{html,txt}
%dir %{_sysconfdir}/fonts
%{_sysconfdir}/fonts/fonts.conf
%{_sysconfdir}/fonts/fonts.dtd
%config %{_sysconfdir}/fonts/local.conf
%{_bindir}/fc-*
%{_libdir}/libfontconfig*.so.*
%{_mandir}/man5/*

%files devel
%defattr(-, root, root)
%doc doc/fontconfig-devel.txt doc/fontconfig-devel/*
%dir %{_includedir}/fontconfig
%{_includedir}/fontconfig
%{_libdir}/*.a
%{_libdir}/*.la
%{_libdir}/libfontconfig.so
%{_libdir}/pkgconfig
%{_mandir}/man3/*

%changelog
* Fri Mar  7 2003 Mike A. Harris <mharris@redhat.com> 2.1.92-1
- Removed man1/* and added man5/* to main package and man3/* to devel package
- Added missing defattr(-, root, root) to main package
- Added HTML and text development documentation to -devel subpackage

* Wed Mar  5 2003 Mike A. Harris <mharris@redhat.com>
- Added back the configure macro options --disable-docs because otherwise
  fontconfig installs docs into /usr/share/doc/fontconfig (with no version
  number) unconditionally, causing RPM to fail the build due to unpackaged
  files terminate build

* Wed Mar  5 2003 Mike A. Harris <mharris@redhat.com>
- Removed commented out rpm macro define at top of spec file, replacing it with
  a simple explanation, since rpm macros are expanded by rpm even in comments
- Changed /usr/bin to _bindir in BuildRequires lines
- Cleaned up rpm postinstall script, and made fc-cache use _bindir
- Reorganized file manifest lists

* Sun Mar  2 2003 Owen Taylor <otaylor@redhat.com>
- Various improvements from Red Hat spec file

* Sun Mar  2 2003 Mike A. Harris <mharris@redhat.com>
- Initial changelog entry
