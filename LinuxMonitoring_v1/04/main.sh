#!/bin/bash

function Color () {
  case "$2" in  #font color
    "6" )       colorString='\033[30m';; # Black
    "2" )         colorString='\033[31m';; #Red
    "3" )       colorString='\033[32m';; #Green
    "4" )        colorString='\033[34m';; #Blue
    "5" )     colorString='\033[35m';; #Purple
    "1" )       colorString='\033[37m';; #White
    *)              colorString='\033[0;39m';;
  esac

  case "$1" in   #background color
    "6" )       colorString="${colorString}\033[40m";; #Black
    "2" )         colorString="${colorString}\033[41m";; #Red
    "3" )       colorString="${colorString}\033[42m";; #Green
    "4" )        colorString="${colorString}\033[44m";; #Blue
    "5" )     colorString="${colorString}\033[45m";; #Purple
    "1" )       colorString="${colorString}\033[47m";; # White
    *)              colorString="${colorString}\033[49m";;
  esac

  echo "${colorString}"
}

function get_par () {
  #res=$(cat colors.conf | grep "$1" | sed "s/${1}//" | grep -oE "[1-6]")
  res=$(cat colors.conf | grep "$1" | grep -oE "=.*$" | sed "s/=//" | sed 's/\s*//g')
  local reg="^[0-9]+$"
  if [[ ! "$res" =~ $reg ]]; then
    res=0
  fi
  echo "$res"
}

function get_color_name () {
  case "$1" in
    "1") res="white";;
    "2") res="red";;
    "3") res="green";;
    "4") res="blue";;
    "5") res="purple";;
    "6") res="black";;
    *)   res="error";;
  esac
  echo "$res"
}

if [ -e "colors.conf" ]
then
  column1_background=$(get_par "column1_background")
  column1_font_color=$(get_par "column1_font_color")
  column2_background=$(get_par "column2_background")
  column2_font_color=$(get_par "column2_font_color")
fi

c1bp=$column1_background
c1fcp=$column1_font_color
c2bp=$column2_background
c2fcp=$column2_font_color

check_default () {
  if [[ -z "$1" || "$1" -lt "1" || "$1" -gt "6" ]]; then
    return 0
  else
    return 1
  fi
}

#if [[ -z "$column1_background" || "$column1_background" -lt "1" || "$column1_background" -gt "6" ]]
if check_default "$column1_background"
then
  column1_background=6
  c1bp="default"
fi
#if [ -z "$column1_font_color" ];
if check_default "$column1_font_color"
then
  column1_font_color=1;
  c1fcp="default"
fi
#if [ -z "$column2_background" ];
if check_default "$column2_background"
then
  column2_background=2;
  c2bp="default"
fi
#if [ -z "$column2_font_color" ];
if check_default "$column2_font_color"
 then
  column2_font_color=4;
  c2fcp="default"
fi

if [[ $column1_background -eq $column1_font_color || $column2_background -eq $column2_font_color ]]
then
  echo "Error: Font and background colors must not match. Please, fix it in the file colors.conf"
else
  colorName=$(Color $column1_background $column1_font_color)
  colorVal=$(Color $column2_background $column2_font_color)
  ./info.sh $colorName $colorVal
fi

c1bn=$(get_color_name "$column1_background")
c1fcn=$(get_color_name "$column1_font_color")
c2bn=$(get_color_name "$column2_background")
c2fcn=$(get_color_name "$column2_font_color")

echo
echo "Column 1 background = $c1bp ($c1bn)"
echo "Column 1 font color = $c1fcp ($c1fcn)"
echo "Column 2 background = $c2bp ($c2bn)"
echo "Column 2 font color = $c2fcp ($c2fcn)"
