# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils

DESCRIPTION="Open Source next generation intrusion detection and prevention engine"
HOMEPAGE="http://openinfosecfoundation.org/"
SRC_URI="http://openinfosecfoundation.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="nfqueue pfring"

DEPEND="
    dev-libs/libpcre
    net-libs/libnet:1.1
    dev-libs/libyaml
    net-libs/libpcap
    sys-libs/zlib
    app-text/htp
    nfqueue? (
        net-libs/libnetfilter_queue
        net-libs/libnfnetlink
    )
    pfring? ( >=net-libs/libpfring-4.0 )
"
RDEPEND="${DEPEND}"

src_compile() {
    econf
#        $(use_enable nfqueue ) \
#        $(use_enable pfring )

    emake || die "emake failed"
}

src_install() {
    emake DESTDIR="${D}" install || die "install failed"
}

