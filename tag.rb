require 'set'

@want = Set['K9OX', 'KD7MPA', 'N0OK']

def propagate line
  if line.match(/\b#{@want.to_a.join("|")}\b/)
    tags = line.scan(/\b[A-Z]+\d[A-Z]+/)
    @want.merge tags
    return tags
  end
  []
end

conf = File.readlines('conf.txt')
show = File.readlines('show.txt')

conf.each do |line|
  break if line == show.first
  propagate line
end

got = Set.new
show.each do |line|
  got.merge propagate(line)
end

tags = got.to_a.join("\n")
puts tags
