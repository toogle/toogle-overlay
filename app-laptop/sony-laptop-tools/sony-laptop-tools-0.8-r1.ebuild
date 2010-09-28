# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Author: Valery Novikov (devel0per) $

inherit eutils linux-mod

DESCRIPTION="This is a set of tools for Sony Vaio notebooks"
HOMEPAGE="http://devel0per-soft.blogspot.com/"
SRC_URI="mirror://sourceforge/sonylaptoptools/${P}.tbz2"

LICENSE="GPL2"

SLOT="0"
KEYWORDS="x86 amd64"
IUSE="+osd +nvidia +intel -hybridvideo"

DEPEND="sys-power/acpid
		x11-apps/xset
		media-sound/alsa-utils
		sys-apps/pciutils
		nvidia? ( media-video/nvclock )
		hybridvideo? ( media-video/nvclock )
		osd? ( x11-libs/xosd )
		x11-misc/xbindkeys"

RDEPEND="${DEPEND}"

preinstall_check()
{
	ebegin "Checking kernel options ..."
	
	linux-mod_pkg_setup

	if ! linux_chkconfig_present SONY_LAPTOP
	then
		eerror "For new sony models, SONY_LAPTOP kernel"
		eerror "option maybe needed..."
	fi
}

pkg_setup()
{
	preinstall_check
}

src_compile()
{
	echo "$PWD"
	epatch "${FILESDIR}/xbindkeys-display-detection.patch"
	update_configs
}

update_configs()
{
	COMMON_CONF='etc/sony-laptop-tools/common.conf'
	TMP_BUFFER='buffer.bak'
	if ! use hybridvideo; then
		sed -e '/xorg_autoswitch_video/ d' -e '/xorg_conf/ d' $COMMON_CONF > $TMP_BUFFER
		mv $TMP_BUFFER $COMMON_CONF
	fi

	if ! use osd; then
		sed -e '/osd/ d' -e '/OSD/ d' $COMMON_CONF > $TMP_BUFFER
		mv $TMP_BUFFER $COMMON_CONF
	fi
}

src_install()
{
	dobin usr/bin/sony-*
	dobin usr/bin/x11-wrapper
	cp -rf ${S}/etc ${D}
}

pkg_postinst()
{
	cat $S/README
	if use hybridvideo; then
		ewarn "Attention!!! You've enabled hybridvideo flag. Please set correct"
		ewarn "values for xorg_conf_* variables in /etc/sony-laptop-tools/common.conf file."
		ewarn "If you didn't this, /etc/X11/xorg.conf will be replaced by default file"
		ewarn "after first video cards switching."
	fi
}
