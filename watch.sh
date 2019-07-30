# diagram recent wiki-plugin-wsjt traffic
# usage: sh watch.sh 20

while sleep 15; do

 curl -s ward.asia.wiki.org/plugin/wsjt/copy |\
  tee copy.txt | grep ' R[R012-]' |\
  tee conf.txt | tail -${1:-250} > show.txt

 (echo strict digraph { rankdir=LR layout=neato

  echo node [style=filled fillcolor=palegreen]
  cat show.txt | perl -ne '
   print "$&\n" while(/\b[A-Z]+\d[A-Z]+\b/g)' |\
   egrep -v '^[WKAN]' |\
   sort | uniq

  echo node [fillcolor=bisque]
  cat show.txt | perl -ne '
   print "$2 -> $1\n"
   while(/([A-Z]+\d[A-Z]+) ([A-Z]+\d[A-Z]+)/g)' |\
   sort | uniq

  echo } ) |\
 tee map.dot | dot -Tsvg > view.svg
 cp map.dot view.dot
 wc -l map.dot

done