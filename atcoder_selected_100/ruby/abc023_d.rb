# 21
# ABC023/D
# 二分探索

N = gets.to_i
HS = Array.new(N) { gets.split.map(&:to_i) }
H_MIN, H_MAX = HS.map { _1[0] + _1[1] * (N - 1) }.minmax

# 最大の高さを二分探索
ans = (H_MIN .. H_MAX).bsearch do |h_max|
  # h_maxの高さになる時間が速い順に並べて順番に処理した時、全てh_max以内に収まるかを貪欲法で確認
  HS.map { (h_max - _1[0]) / _1[1] }.sort.map.with_index {|i, j| i >= j }.all?
end

puts ans
