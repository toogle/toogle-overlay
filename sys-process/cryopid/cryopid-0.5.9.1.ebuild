# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Process freezing utility"
HOMEPAGE="http://cryopid.berlios.de"
SRC_URI="
	amd64? ( http://dagobah.ucc.asn.au/wacky/${P}-x86_64.tar.gz )
	x86? ( http://dagobah.ucc.asn.au/wacky/${P}-i386.tar.gz )
	"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_compile(){
	cd ${S}/src
	emake || die
}

src_install(){
	dobin src/freeze src/fork2_helper
	dodoc CREDITS ChangeLog README TODO
}
