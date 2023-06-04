# G

N, M = gets.split.map(&:to_i)
G = Array.new(N) { [] }
M.times do
  x, y = gets.split.map(&:to_i).map(&:pred)
  G[x] << y
end

allows = [0] * N
G.flatten.each { allows[_1] += 1 }
next_candicates = N.times.filter { allows[_1].zero? }

depth = [0] * N
until next_candicates.empty?
  pos = next_candicates.shift
  G[pos].each do |i|
    allows[i] -= 1
    next_candicates << i if allows[i].zero?
    next if depth[i] > depth[pos] + 1
    depth[i] = depth[pos] + 1
  end
end

puts depth.max
