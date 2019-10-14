# emit nodes with bold border for calls in log.adi

require 'set'

show = File.readlines('show.txt')
log = File.readlines('log.adi')

calls = Set.new()
show.each do |line|
  line.scan(/\b[A-Z]+\d{1,2}[A-Z]+\b/).each do |call|
    calls << call
  end
end

worked = Set.new()
log.each do |line|
  if m = line.match(/^<call:\d+>(.+?) </)
    worked << m[1]
  end
end

calls.to_a.sort.each do |call|
  width = worked.include?(call) ? " penwidth=3" : ''
  puts "#{call} [URL=\"https://duckduckgo.com/?q=#{call}\"#{width}]"
end
