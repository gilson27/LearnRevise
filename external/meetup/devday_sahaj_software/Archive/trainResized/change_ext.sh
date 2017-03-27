# Rename all *.Bmp to *.bmp
for f in *.Bmp; do
mv "$f" "$(basename "$f" .Bmp).bmp"
done
