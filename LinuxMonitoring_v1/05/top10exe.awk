{
  e = substr($1, length($1), 1);
  if (match(e, /[A-Z]/) == 0) {
    $1 = $1" B"
  } else {
    sub(/[A-Z]{1}$/, " "e"B", $1);
  }
  sub(/,0/, "", $1);
  match($2, /\.[^\.]*$/);
  
  cmd = "md5sum " $2
  cmd | getline md5
  close(cmd)
  md5 = substr(md5, 1, 32)

  print FNR" - "$2", "$1", " md5
}
