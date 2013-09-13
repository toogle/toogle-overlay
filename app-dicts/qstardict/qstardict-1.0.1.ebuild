# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils qt4-r2
DESCRIPTION="QStarDict is a StarDict clone written with using Qt"
HOMEPAGE="http://qstardict.ylsoftware.com/"
SRC_URI="http://qstardict.ylsoftware.com/files/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ia64"

IUSE="dbus nls"
PLUGINS="stardict web"
for p in $PLUGINS; do
	IUSE="${IUSE} ${p}"
done

RDEPEND="
	dev-qt/qtcore
	dev-qt/qtgui
	dbus? ( dev-qt/qtdbus )
	>=dev-libs/glib-2.0"
DEPEND="${RDEPEND}"
PROVIDE="virtual/stardict"

src_prepare() {
	find "${WORKDIR}" -name '*pr?' -exec sed "s:/lib:/$(get_libdir):" -i '{}' \;

	# fix gcc-4.4.1 compatibility
	sed 's/def Q_OS_WIN32/ defined(Q_OS_WIN32)/' -i plugins/stardict/dictziplib.cpp
}

src_compile() {
	QMAKE_FLAGS=""
	if ! use dbus; then
		QMAKE_FLAGS+="NO_DBUS=1 "
	fi
	if ! use nls; then
		QMAKE_FLAGS+="NO_TRANSLATIONS=1 "
	fi
	eplugins=""
	for f in $PLUGINS; do
		use "${f}" && eplugins="${eplugins} ${f}"
	done
	[ "${eplugins}" == "" ] && die "Enable at least one plugin"

	eqmake4 "${PN}".pro $QMAKE_FLAGS ENABLED_PLUGINS="${eplugins}" || die "qmake failed"
	emake || die "emake failed"
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "emake install filed"
}
