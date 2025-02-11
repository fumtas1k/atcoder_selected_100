# -
# ABC302/E
# その他
# SET

require "set"

N, Q = gets.split.map(&:to_i)
connections = Array.new(N) { Set.new }

ans = []
cnt = N
Q.times do
  case gets.split.map(&:to_i).map(&:pred)
  in [0, u, v]
    cnt -= 1 if connections[u].size.zero?
    cnt -= 1 if connections[v].size.zero?
    connections[u] << v
    connections[v] << u
  in [1, u]
    connections[u].each do |v|
      connections[v].delete(u)
      cnt += 1 if connections[v].size.zero?
    end
    cnt += 1 if connections[u].size > 0
    connections[u].clear
  end
  ans << cnt
end

puts ans
