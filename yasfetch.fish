#!/usr/bin/fish

### Variables

set -l noLogo false

if contains -- --off $argv
  set noLogo true
end

function toLower
  echo $argv | tr '[:upper:]' '[:lower:]'
end

set -l user (whoami)
set -l host (cat /sys/devices/virtual/dmi/id/product_version)
set -l os (cat /etc/fedora-release | awk -F " " '{print $1 " " $3}')
set -l kernel (uname -r | sed 's/.x86_64//')
set -l de (gnome-shell --version)
set -l shell (basename $SHELL)
set -l session $XDG_SESSION_TYPE
set -l uptime (uptime)

### Lower mode
set host (toLower $host)
set de (toLower $de)
set os (toLower $os)

if test $shell = "fish"
  set -l $shell (fish -v | sed "s/, version//")
end


## Definir colores

set -l bold (set_color -o white)
set -l magenta (set_color magenta)
set -l green (set_color green)
set -l white (set_color white)
set -l blue (set_color blue)
set -l red (set_color red)
set -l black (set_color black)
set -l yellow (set_color yellow)
set -l cyan (set_color cyan)
set -l reset (set_color normal)

## Labels
set -l lc $reset$bold$blue    # Label
set -l nc $reset$bold$magenta # user
set -l ic $reset

set -l c1 $reset$blue
set -l c2 $reset$white
set -l c3 $reset$magenta
set -l c4 $reset$blue
set -l c5 $reset$red
set -l c6 $reset$yellow
set -l c7 $reset$green

if $noLogo
  set logo[1] ""
  set logo[2] ""
  set logo[3] ""
  set logo[4] ""
  set logo[5] ""
  set logo[6] ""
  set logo[7] ""
  set logo[8] ""
  set logo[9] ""
else
  set logo[1] "$c1                 "
  set logo[2] "$c1    FFFFFF       "
  set logo[3] "$c1  FFFF"$c2"FFF"$c1"FFF     "
  set logo[4] "$c1 FFFFF"$c2"F"$c1"FF"$c2"F"$c1"FFF    "
  set logo[5] "$c1 FFF"$c2"F"$c1"F"$c2"FFF"$c1"FFFF    "
  set logo[6] "$c1 FF"$c2"F"$c1"FF"$c2"F"$c1"FFFFFF    "
  set logo[7] "$c1 FFF"$c2"FFF"$c1"FFFFF     "
  set logo[8] "$c1 FFFFFFFFF       "
  set logo[9] "                  "
end

set logo[1] $logo[1]$nc"us $ic• $user"
set logo[2] $logo[2]$lc"ho $ic• $host"
set logo[3] $logo[3]$lc"os $ic• $os"
set logo[4] $logo[4]$lc"kr $ic• $kernel"
set logo[5] $logo[5]$lc"de $ic• $de"
set logo[6] $logo[6]$lc"sh $ic• $shell"
set logo[7] $logo[7]$lc"se $ic• $session"
set logo[8] $logo[8]$lc"up $ic• $uptime"
set logo[9] $logo[9]$lc"$c6󰮯 • $c5󰊠  $c3󰊠  $c1󰊠  $c7󰊠"

for i in (seq 9)
	echo $logo[$i]
end
