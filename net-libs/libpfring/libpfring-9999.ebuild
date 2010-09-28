# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit subversion eutils toolchain-funcs linux-info

DESCRIPTION="A a new type of network socket that dramatically improves packet capture speed"
HOMEPAGE="http://www.ntop.org/PF_RING.html"
ESVN_REPO_URI="https://svn.ntop.org/svn/ntop/trunk/PF_RING"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"

pkg_setup() {
    linux-info_pkg_setup

    ebegin "Checking for CONFIG_RING enabled kernel..."
    linux_chkconfig_present RING
    eend $?
    if [[ $? -ne 0 ]] ; then
        eerror 
        eerror "You don't have a PF_RING enabled kernel!"
        eerror 
        die &> /dev/null
    fi

    ebegin "Checking to see if CONFIG_RING is a module..."
    linux_chkconfig_module RING
    eend $?
    if [[ $? -ne 0 ]] ; then
        eerror 
        eerror "CONFIG_RING needs to be compiled as a module!"
        eerror
        die &> /dev/null
    fi
}

src_unpack() {
    subversion_src_unpack
}

src_compile() {
    # There is no ./configure

    # Add -fPIC to the Makefile to prevent runtime text relocations.
    sed -i s/'CC=gcc -g'/'CC=gcc -g -fPIC'/ Makefile
    emake || die "emake failed"
    $(tc-getCC) -Wl,-soname -Wl,libpfring.so.${PV} -shared -fPIC -o libpfring.so.${PV} *.o -lc \
    || die "failed to make a shared library"
}

src_install() {
    # No 'make install' either.

    insopts -m 644
    insinto /usr/$(get_libdir); doins libpfring.a
    insinto /usr/include; doins pfring.h

    insopts -m 755
    insinto /usr/$(get_libdir) ; doins libpfring.so.${PV}
    dosym libpfring.so.${PV} /usr/$(get_libdir)/libpfring.so
    dosym libpfring.so.${PV} /usr/$(get_libdir)/libpfring.so.3
}
