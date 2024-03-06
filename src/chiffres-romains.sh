#!/bin/sh

if [ $# -ne 1 ]; then
    echo "./exo5.sh nombre"
    exit 1
fi

dec=$1
chifrom=""

while [ $dec -gt 0 ] ; do

  if [ $dec -ge 1000 ] ; then
    chifrom="${chifrom}M"
    dec=$(($dec - 1000))
  elif [ $dec -ge 900 ] ; then
    chifrom="${chifrom}CM"
    dec=$(($dec - 900))
  elif [ $dec -ge 500 ] ; then
    chifrom="${chifrom}D"
    dec=$(($dec - 500))
  elif [ $dec -ge 400 ] ; then
    chifrom="${chifrom}CD"
    dec=$(($dec - 400))
  elif [ $dec -ge 100 ] ; then
    chifrom="${chifrom}C"
    dec=$(($dec - 100))
  elif [ $dec -ge 90 ] ; then
    chifrom="${chifrom}XC"
    dec=$(($dec - 90))
  elif [ $dec -ge 50 ] ; then
    chifrom="${chifrom}L"
    dec=$(($dec - 50))
  elif [ $dec -ge 40 ] ; then
    chifrom="${chifrom}XL"
    dec=$(($dec - 40))
  elif [ $dec -ge 10 ] ; then
    chifrom="${chifrom}X"
    dec=$(($dec - 10))
  elif [ $dec -ge 9 ] ; then
    chifrom="${chifrom}IX"
    dec=$(($dec - 9))
  elif [ $dec -ge 5 ] ; then
    chifrom="${chifrom}V"
    dec=$(($dec - 5))
  elif [ $dec -ge 4 ] ; then
    chifrom="${chifrom}IV"
    dec=$(($dec - 4))
  elif [ $dec -ge 1 ] ; then
    chifrom="${chifrom}I"
    dec=$(($dec - 1))
  fi

done

echo $chifrom

exit 0