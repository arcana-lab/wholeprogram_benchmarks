#!/bin/sh

fileInput="input_verylarge.asc";
if ! test -f $fileInput ; then
  xz -d ${fileInput}.xz ;
fi
