# -
# ABC427/C
# 全探索:ビット全探索
# 二部グラフの判定

N, M = gets.split.map(&:to_i)
UV = Array.new(M) { gets.split.map(&:to_i).map(&:pred) }

ans = [0] * (1 << N)
(1 << N).times do |bit|
  UV.each do |u, v|
    next if bit[u] != bit[v]
    ans[bit] += 1
  end
end

puts ans.min
