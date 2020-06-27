require 'set'

@want = Set['K9OX','KD7MPA','W9YB','K1JT','AI6TK','N8JEA','KF7O']

@first = @match = @view = @last = nil

def propagate line
  if line.match(/\b(#{@want.to_a.join("|")})\b/)
    tags = line.scan(/\b[A-Z]+\d[A-Z]+/)
    @want.merge tags
    @match ||= line
    return tags
  end
  []
end

conf = File.readlines('conf.txt')
show = File.readlines('show.txt')

conf.each do |line|
  @first ||= line
  break if line == show.first
  propagate(line)
end

got = Set.new
show.each do |line|
  @view ||= line
  got.merge propagate(line)
  @last = line
end

STDERR.puts
STDERR.puts "first #{@first}"
STDERR.puts "match #{@match}"
STDERR.puts "view #{@view}"
STDERR.puts "last #{@last}"

tags = got.to_a.join("\n")
puts tags
