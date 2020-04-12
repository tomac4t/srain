#!/bin/bash
set -ex
rm -rf srain-contrib;
rm -rf debian;
if [ $1 = "ci" ]; then
sudo apt-get install pkg-config gettext libgtk-3-dev libsoup2.4-dev libconfig-dev libssl-dev libsecret-1-dev glib-networking libgtk3.0 libsoup2.4 libconfig9 libsecret-1-0;
fi
SRAIN_HOME=$PWD;
SRAIN_TAG=`git rev-list --tags --max-count=1`;
SRAIN_TAGNAME=`git describe --tags $SRAIN_TAG`;
#SRAIN_TAG_COMMITTER_NAME=`git show --pretty=format:"%an" --oneline $SRAIN_TAG | head -n 1`
#SRAIN_TAG_COMMITTER_EMAIL=`git show --pretty=format:"%ae" --oneline $SRAIN_TAG | head -n 1`;
#SRAIN_TAG_DATE=`git show --pretty=format:"%ad" --oneline --date=format:'%a, %d %b %Y %H:%M:%S %z' $SRAIN_TAG | head -n 1`;
SRAIN_TAG_COMMITTER_NAME=`git log $SRAIN_TAG -n 1 --pretty=format:"%an"`;
SRAIN_TAG_COMMITTER_EMAIL=`git log $SRAIN_TAG -n 1 --pretty=format:"%ae"`;
SRAIN_TAG_DATE=`git log $SRAIN_TAG -n 1 --pretty=format:"%ad" --date=format:'%a, %d %b %Y %H:%M:%S %z'`;
#SRAIN_TAG_COMMITTER_NAME="GitHub Actions"
#SRAIN_TAG_COMMITTER_EMAIL="tomac4t@users.noreply.github.com"
#SRAIN_TAG_DATE=`date "+%a, %d %b %Y %H:%M:%S %z"`
git clone https://github.com/SrainApp/srain-contrib.git --depth 1;
cd srain-contrib;
mv pack/debian $SRAIN_HOME/debian;
cat > $SRAIN_HOME/debian/changelog << EOF
srain ($SRAIN_TAGNAME) unstable; urgency=medium

  * New upstream version $SRAIN_TAGNAME

 -- $SRAIN_TAG_COMMITTER_NAME <$SRAIN_TAG_COMMITTER_EMAIL>  $SRAIN_TAG_DATE
EOF
echo "11" > $SRAIN_HOME/debian/compat
cat > $SRAIN_HOME/debian/control << EOF
Source: srain
Section: net
Priority: optional
Maintainer: Shengyu Zhang <i@silverrainz.me>
Build-Depends:
	gettext,
	libconfig-dev,
	libgtk-3-dev,
	libsecret-1-dev,
	libsoup2.4-dev,
	libssl-dev,
	pkg-config,
Standards-Version: 4.5.0
Rules-Requires-Root: no
Homepage: https://github.com/SrainApp/srain/
Vcs-Browser: https://github.com/SrainApp/srain/
Vcs-Git: https://github.com/SrainApp/srain.git

Package: srain
Architecture: any
Depends:
	${shlibs:Depends},
	${misc:Depends},
	glib-networking,
	libconfig9 (>= 1.5),
	libgtk-3-0 (>= 3.16),
	libsecret-1-0,
	libsoup2.4-1,
Description: Modern IRC client
 Modern IRC client written in GTK.
EOF
cd $SRAIN_HOME;
rm -rf srain-contrib;
dpkg-buildpackage -b -us -uc;
mkdir out;
mv ../srain_"$SRAIN_TAGNAME"_amd64.deb $PWD/out/
sudo apt-get install $PWD/out/srain_"$SRAIN_TAGNAME"_amd64.deb;
/usr/bin/srain --version;