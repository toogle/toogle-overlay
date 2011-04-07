# Copyright 1999-2008 Gentoo Foundation    
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit kde4-base

CONTENT_NUMBER="109367"

DESCRIPTION="Yes, Yet another systemmonitor plasmoid. But still different from the others"
HOMEPAGE="http://www.kde-look.org/content/show.php/Yasp-Scripted?content=109367"
LICENSE="GPL"

KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
SLOT="0"

SRC_URI="http://www.kde-look.org/CONTENT/content-files/${CONTENT_NUMBER}-yasp-scripted-${PV}.tar.bz2"

DEPEND="kde-base/kdelibs"

S="${WORKDIR}/yasp-scripted-${PV}"
