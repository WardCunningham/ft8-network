while sleep 15; do
 (echo strict digraph { rankdir=LR layout=neato
 echo node [style=filled fillcolor=palegreen]
 sh hot.sh
 echo node [fillcolor=bisque]
 curl -s ward.asia.wiki.org/plugin/wsjt/copy |\
  grep ' R[R012-]' |\
  tail -1000 |\
  perl -ne '
   print "$2 -> $1\n"
   while(/([A-Z]+\d[A-Z]+) ([A-Z]+\d[A-Z]+)/g)' |\
  sort | uniq ;
 echo } ) > raw.dot
 cp raw.dot map.dot
 dot -Tsvg map.dot > map.svg
 wc -l map.dot
done