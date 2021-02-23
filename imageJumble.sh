#!/bin/bash
#most of this script came from : https://stackoverflow.com/questions/28142106/how-to-cut-image-into-pieces-randomize-them-and-put-all-together
# and https://stackoverflow.com/questions/1298066/check-if-an-apt-get-package-is-installed-and-then-install-it-if-its-not-on-linu
# I just packaged it up and cleaned things up a smidgeon for extensibility 

input=$1
output=$2
horizontal=$3
vertical=$4
crop=$(echo $horizontal'x'$vertical)

REQUIRED_PKG="imagemagick"
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $REQUIRED_PKG|grep "install ok installed")
echo Checking for $REQUIRED_PKG: $PKG_OK
if [ "" = "$PKG_OK" ]; then
  echo "No $REQUIRED_PKG. Setting up $REQUIRED_PKG."
  sudo apt-get --yes install $REQUIRED_PKG 
fi

# Get original image geometry
origgeom=$(identify -format %g $input)
echo $origgeom
# Calculate new geometry as exact multiple of tilesize
newgeom=$(convert $input -format "%[fx:int(w/$horizontal)*$horizontal]x%[fx:int(h/$vertical)*$vertical]" info:)
echo $newgeom

# Resize to new geometry and tile
# anyway to change this 4x4 to reflect the passed in horizontal and vertical?
convert $input -resize $newgeom -crop $crop@ tempTile.jpg;

# Rebuild in random order then correct geometry
montage -background none -geometry +0+0 $(ls tempTile*jpg | awk 'BEGIN{srand()}{print rand() "\t" $0}' | sort -n | cut -f2-) JPG:- | convert JPG: -resize ${origgeom}! $output

rm tempTile-*.jpg;
