#!/bin/bash
set -ex
# Install the dependencies.
if [ $1 = "ci" ]; then
apt-get install -y dpkg-dev pkg-config gettext libgtk-3-dev libsoup2.4-dev libconfig-dev libssl-dev libsecret-1-dev glib-networking libgtk3.0 libsoup2.4 libconfig9 libsecret-1-0;
git fetch origin +refs/tags/*:refs/tags/*
fi
SRAIN_HOME=$PWD;
SRAIN_TAG=`git rev-list --tags --max-count=1`;
SRAIN_TAG_NAME=`git describe --tags $SRAIN_TAG`;
SRAIN_TAG_COMMITTER_NAME=`git log $SRAIN_TAG -n 1 --pretty=format:"%an"`;
SRAIN_TAG_COMMITTER_EMAIL=`git log $SRAIN_TAG -n 1 --pretty=format:"%ae"`;
SRAIN_TAG_DATE=`git log $SRAIN_TAG -n 1 --pretty=format:"%ad" --date=format:'%a, %d %b %Y %H:%M:%S %z'`;
# Download the debian files.
git clone https://github.com/SrainApp/srain-contrib.git --depth 1;
cd srain-contrib;
mv pack/debian $SRAIN_HOME/debian;
cat > $SRAIN_HOME/debian/changelog << EOF
srain ($SRAIN_TAG_NAME) unstable; urgency=medium

  * New upstream version $SRAIN_TAG_NAME

 -- $SRAIN_TAG_COMMITTER_NAME <$SRAIN_TAG_COMMITTER_EMAIL>  $SRAIN_TAG_DATE
EOF
cd $SRAIN_HOME;
rm -rf srain-contrib;
dpkg-buildpackage -b -us -uc;
mkdir $SRAIN_HOME/out;
mv $SRAIN_HOME/../srain_"$SRAIN_TAG_NAME"_amd64.deb $SRAIN_HOME/out/
sudo apt-get install $SRAIN_HOME/out/srain_"$SRAIN_TAG_NAME"_amd64.deb;
/usr/bin/srain --version;
# Changelog
CHANGELOG_LINE=`grep -oP "^========================" $SRAIN_HOME/doc/changelog.rst -n | awk -F: '{print $1}'`;
CHANGELOG_LINE_ONE=`echo $CHANGELOG_LINE | awk '{print $1}'`;
CHANGELOG_LINE_TWO=`echo $CHANGELOG_LINE | awk '{print $2}'`;
CHANGELOG_LASTEST_BEGIN=`expr $CHANGELOG_LINE_ONE + 2`
CHANGELOG_LASTEST_END=`expr $CHANGELOG_LINE_TWO - 5`
sed -n "$CHANGELOG_LASTEST_BEGIN","$CHANGELOG_LASTEST_END"p $SRAIN_HOME/doc/changelog.rst  > $SRAIN_HOME/.github/changelog 
sed -i s/":pull:.\([0-9]*\)."/"#\1"/g $SRAIN_HOME/.github/changelog;
sed -i s/":issue:.\([0-9]*\)."/"#\1"/g $SRAIN_HOME/.github/changelog;
sed -i s/":commit:.\([0-9a-z]*\)."/"SrainApp\/srain@\1"/g $SRAIN_HOME/.github/changelog;
sed -i /"^\s*$"/d $SRAIN_HOME/.github/changelog;