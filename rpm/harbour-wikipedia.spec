# 
# Do NOT Edit the Auto-generated Part!
# Generated by: spectacle version 0.27
# 

Name:       harbour-wikipedia

# >> macros
# << macros

%{!?qtc_qmake:%define qtc_qmake %qmake}
%{!?qtc_qmake5:%define qtc_qmake5 %qmake5}
%{!?qtc_make:%define qtc_make make}
%{?qtc_builddir:%define _builddir %qtc_builddir}
Summary:    Wikipedia for Sailfish OS
Version:    0.2
Release:    3
Group:      Qt/Qt
License:    All rights reserved
Source0:    %{name}-%{version}.tar.bz2
Source100:  harbour-wikipedia.yaml
Requires:   libsailfishapp
BuildRequires:  pkgconfig(Qt5Core)
BuildRequires:  pkgconfig(Qt5Qml)
BuildRequires:  pkgconfig(Qt5Quick)
BuildRequires:  pkgconfig(sailfishapp)
BuildRequires:  desktop-file-utils

%description
Simple Wikipedia app for Sailfish OS

%package test
Summary:    Tests for the Wikipedia app
Group:      Qt/Qt
Requires:   %{name} = %{version}-%{release}
Requires:   qt5-qtdeclarative-import-qttest
BuildRequires:  pkgconfig(Qt5QuickTest)

%description test
Tests package for the Wikipedia app

%package fake
Summary:    Collects mixpanel tests
Group:      Qt/Qt
Requires:   %{name} = %{version}-%{release}

%description fake
Removes from RPM files that would cause QA scripts warnings.

%prep
%setup -q -n %{name}-%{version}

# >> setup
# << setup

%build
# >> build pre
# << build pre

%qtc_qmake5 

%qtc_make %{?_smp_mflags}

# >> build post
# << build post

%install
rm -rf %{buildroot}
# >> install pre
# << install pre
%qmake5_install

# >> install post
# << install post

desktop-file-install --delete-original       \
  --dir %{buildroot}%{_datadir}/applications             \
   %{buildroot}%{_datadir}/applications/*.desktop

%files
%defattr(-,root,root,-)
%{_datadir}/applications
%{_datadir}/icons/hicolor/86x86/apps/%{name}.png
%{_datadir}/applications/%{name}.desktop
%{_datadir}/%{name}/qml/main.qml
%{_datadir}/%{name}/qml/pages
%{_datadir}/%{name}/qml/cover
%{_datadir}/%{name}/qml/components/*.qml
%{_datadir}/%{name}/qml/components/harbour
%{_datadir}/%{name}/qml/components/AppStoreKeys
%{_bindir}/%{name}
# >> files
# << files

%files test
%defattr(-,root,root,-)
%{_bindir}/tst-harbour-wikipedia
%{_datadir}/tst-harbour-wikipedia/*.qml
%{_datadir}/tst-harbour-wikipedia/*.sh
# >> files test
# << files test

%files fake
%defattr(-,root,root,-)
%{_datadir}/%{name}/qml/components/Mixpanel/*
%{_datadir}/%{name}/qml/components/Mixpanel/.*
# >> files fake
# << files fake
