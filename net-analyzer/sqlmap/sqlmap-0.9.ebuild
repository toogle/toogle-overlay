# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Automatic SQL injection and database takeover tool"
HOMEPAGE="http://sqlmap.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-lang/python"
RDEPEND="${DEPEND}"

src_install () {
    #dodoc doc/*
    #rm -rf doc
    dodir /usr/lib/${PN}/
    cp -R * ${D}/usr/lib/
    dosym /usr/lib/${PN}/sqlmap.py /usr/sbin/sqlmap
}
