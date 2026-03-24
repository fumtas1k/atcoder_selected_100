# -
# AWC0013/E
# 深さ優先探索, 二部グラフ
# 最大マッチング
# 最大流量問題

require "ac-library-rb/max_flow"

N, M = gets.split.map(&:to_i)

mf = AcLibraryRb::MaxFlow.new(N + M + 2)
added = Array.new(M + 1, false)
N.times do |i|
  _, *cs = gets.split.map(&:to_i)
  mf.add_edge(0, i + 1, 1)
  cs.each do |c|
    mf.add_edge(i + 1, N + c, 1)
    next if added[c]
    mf.add_edge(N + c, N + M + 1, 1)
    added[c] = true
  end
end

puts mf.flow(0, N + M + 1, N + M)
