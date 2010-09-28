# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="libfprint"
HOMEPAGE="http://www.reactivated.net/fprint/wiki/Libfprint"
SRC_URI="mirror://sourceforge/fprint/${P/_/-}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=dev-libs/libusb-1.0.0
	dev-libs/openssl
	media-gfx/imagemagick"

S="${WORKDIR}/${P/_/-}"

src_unpack() {
	unpack ${A}
	cd "${S}"
}

src_install() {
	emake DESTDIR="${D}" install
}

