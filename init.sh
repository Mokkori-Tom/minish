#!/bin/sh
#/init.sh
# ENV設定
export HOME="/home"  
export OPT="/opt"
# $PATH設定
export PATH="$PATH:/bin"
export PATH="$PATH:/usr/bin"
export PATH="$PATH:/usr/local/bin"
# bash起動-必ず最後に
exec /usr/bin/bash
