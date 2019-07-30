 curl -s ward.asia.wiki.org/plugin/wsjt/copy |\
  grep ' R[R012-]' |\
  perl -ne 'print "$&\n" while(/\b[A-Z]+\d[A-Z]+\b/g)' |\
  egrep -v '^[WKAN]' |\
  sort | uniq