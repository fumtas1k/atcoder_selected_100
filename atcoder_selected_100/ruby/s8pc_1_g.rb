# 50
# S8PC-1/G
# 動的計画法:bit DP
# 巡回セールスマン問題

# 最短時間 == 最短距離
N, M = gets.split.map(&:to_i)
D = Array.new(N) { Array.new(N, Float::INFINITY) }
T = Array.new(N) { Array.new(N, 0) }

M.times do
  s, t, d, time = gets.split.map(&:to_i)
  s -= 1
  t -= 1
  D[s][t] = D[t][s] = d
  T[s][t] = T[t][s] = time
end

# dists[移動した建物のBIT][現在の建物]
dists = Array.new(1 << N) { Array.new(N, Float::INFINITY) }
cnts = Array.new(1 << N) { Array.new(N, 0) }
# 0スタートで0に戻ってくることからbit=0, i=0を初期化
dists[0][0] = 0
cnts[0][0] = 1

(1 << N).times do |bit|
  N.times do |i|
    next if bit[i] == 1 # すでにjを通っている場合
    N.times do |j|
      next if i == j
      dist = dists[bit][j] + D[j][i]
      next if T[j][i] < dist # 通れる時間を過ぎている場合
      next_bit = bit | (1 << i)
      case dists[next_bit][i] <=> dist
      when 1
        dists[next_bit][i] = dist
        cnts[next_bit][i] = cnts[bit][j]
      when 0
        cnts[next_bit][i] += cnts[bit][j]
      else
        nil
      end
    end
  end
end

puts cnts[-1][0].zero? ? "IMPOSSIBLE" : [dists[-1][0], cnts[-1][0]].join(" ")
