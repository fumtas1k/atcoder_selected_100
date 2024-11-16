# -
# ABC305/E
# 変形ダイクストラ法
# 優先度付きキュー

require "ac-library-rb/priority_queue"

N, M, K = gets.split.map(&:to_i)
G = Array.new(N) { [] }
M.times do
  a, b = gets.split.map(&:to_i).map(&:pred)
  G[a] << b
  G[b] << a
end
PH = Array.new(K) { gets.split.map(&:to_i).then { [_1[0].pred, _1[1]] } }

def dijkstra
  hitpoints = [-10 ** 18] * N
  PH.each {|pos, h| hitpoints[pos] = h }
  log = AcLibraryRb::PriorityQueue.new(PH) {|u, v| _1[1] > _2[1] }
  until log.empty?
    pos, hitpoint = log.pop
    next if hitpoints[pos] > hitpoint

    G[pos].each do |i|
      next if hitpoints[i] >= hitpoints[pos] - 1
      hitpoints[i] = hitpoints[pos] - 1
      log << [i, hitpoints[i]]
    end
  end
  hitpoints
end

ans = dijkstra.filter_map.with_index { _2.succ if _1 >= 0 }
puts [ans.size, ans.join(" ")]
