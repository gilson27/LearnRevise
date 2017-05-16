declare -a arr=(
    "NUMERIC"
    "TIME"
    "MONETARY"
    "PAPER"
    "MEASUREMENT")

lc_ctype="en_US.UTF-8"

for i in ${arr[@]};
  do
     lc="LC_${i}=$lc_ctype"
     echo $lc
  done
