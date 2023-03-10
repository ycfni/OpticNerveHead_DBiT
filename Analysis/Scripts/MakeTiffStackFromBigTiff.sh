INPUTFILE=$1
convert "$INPUFILE" -compress jpeg -quality 90 -define tiff:tile-geometry=256x256 ptif:"${INPUTFILE}_pyramid.tif"

