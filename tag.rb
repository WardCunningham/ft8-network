require 'set'
tags = File.read('tags.txt').split "\n"
want = (Set['K9OX', 'KD7MPA']).merge tags
got = Set.new
File.open('show.txt').each_line do |line|
  if line.match(/\b#{want.to_a.join("|")}\b/)
    here = line.scan(/\b[A-Z]+\d[A-Z]+/)
    want.merge here
    got.merge here
  end
end
tags = got.to_a.join("\n")
File.open('tags.txt','w') do |file|
  file.puts tags
end
puts tags
