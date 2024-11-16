# -
# 動的計画法:ナップサックDP
# 個数制限付きナップサックDP
# 貪欲法
# スライド最小値

N, W = gets.split.map(&:to_i)
VWM = Array.new(N) { gets.split.map(&:to_i) }

max_v = VWM.max_by(&:first)[0]
total_v = VWM.sum { |v, _, m| v * [max_v, m].min }

# dp[i]: 価値が i のときの重さの最小値
dp = Array.new(total_v + 1, W + 1)
dp[0] = 0

VWM.each do |v, w, m|
  limit = [max_v, m].min
  # スライド最小値を用いて、価値が i のときの重さの最小値を求める
  v.times do |other_v|
    deque = []
    j = 0
    while (value = j * v + other_v) <= total_v && j * w <= dp[value]
      other_w = dp[value] - j * w
      deque.pop while !deque.empty? && deque[-1][1] > other_w
      deque.shift while !deque.empty? && limit < j - deque[0][0]
      deque << [j, other_w]
      dp[value] = [dp[value], deque[0][1] + j * w].min
      j += 1
    end
  end
end

# 残りの容量に対して、価値あたり重さの小さい順に貪欲法で詰める
remaining_vwm = VWM.map {|v, w, m| [v, w, m - max_v] if m > max_v }.compact.sort_by {|v, w, _| w.to_f / v }

max_value = 0
dp.each_with_index do |weight, i|
  next if weight > W
  total_value = i
  remaining_w = W - weight
  remaining_vwm.each do |v, w, m|
    take = [m, (remaining_w / w).to_i].min
    total_value += v * take
    remaining_w -= w * take
  end
  max_value = [max_value, total_value].max
end

puts max_value
