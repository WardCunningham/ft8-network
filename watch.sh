# diagram recent wiki-plugin-wsjt traffic
# usage: sh watch.sh 20

while sleep 15; do

 curl -s ward.asia.wiki.org/plugin/wsjt/copy |\
  tee copy.txt | egrep ' (R[+-]|RR73|RRR)' |\
  tee conf.txt | tail -${1:-50} > show.txt

 tail -1 conf.txt

 curl -s found.ward.bay.wiki.org/assets/pages/k9ox-ft8-log/wsjtx_log.adi > log.adi

 (echo strict digraph { rankdir=LR layout=neato

  echo node [style=filled fillcolor=lightblue]
  ruby tag.rb

  echo node [fillcolor=palegreen]
  cat show.txt | perl -ne '
   print "$&\n" while(/\b[A-Z]+\d{1,2}[A-Z]+\b/g)' |\
   egrep -v '^[WKAN]' |\
   sort | uniq

  echo node [fillcolor=bisque]
  cat show.txt | perl -ne '
   print "$2 -> $1\n"
   while(/([A-Z]+\d[A-Z]+) ([A-Z]+\d{1,2}[A-Z]+)/g)' |\
   sort | uniq

  ruby worked.rb

  echo } ) |\
 tee map.dot | dot -Tsvg > view.svg
 cp map.dot view.dot
 scp -q view.svg asia:.wiki/ward.asia.wiki.org/assets/pages/radios-social-network/view.svg

done