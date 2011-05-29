# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit latex-package

MY_PN="PSCyr"
MY_PV="0.4d-beta"
MY_P="${MY_PN}-${PV/_/-}"

DESCRIPTION="Type1 cyrillic fonts collection"
HOMEPAGE="ftp://scon155.phys.msu.su/pub/russian/psfonts/"
SRC_URI="ftp://ftp.vsu.ru/pub/tex/font-packs/${PN}/${MY_PV}/${MY_P}-tex.tar.gz
         ftp://ftp.vsu.ru/pub/tex/font-packs/${PN}/${MY_PV}/${MY_P}-type1.tar.gz"
RESTRICT="mirror"

LICENSE="LPPL-1.2"
SLOT="0"
IUSE=""
KEYWORDS="alpha amd64 hppa mips ppc sparc x86"

S=${WORKDIR}/${MY_PN}

SUPPLIER="public"

src_install() {
	for d in dvips/pscyr tex/latex/pscyr fonts/tfm/public/pscyr  \
	           fonts/vf/public/pscyr fonts/type1/public/pscyr fonts/afm/public/pscyr; do
		cd ${S}/${d}

		latex-package_src_install
	done

	cd ${S}
	insinto ${TEXMF}/fonts/map/dvips/pscyr
	doins dvips/pscyr/pscyr.map || die "doins $i failed"

	for f in dvips/pscyr/*.enc; do
		insinto ${TEXMF}/fonts/enc/dvips/pscyr
		doins $f || die "doins $i failed"
	done

	insinto /etc/texmf/updmap.d
	doins ${FILESDIR}/90pscyr.cfg

	dodoc LICENSE doc/README.* doc/PROBLEMS ChangeLog
}

pkg_postinst() {
	latex-package_pkg_postinst
	updmap
}

pkg_postrm() {
	latex-package_pkg_postrm
	updmap
}
