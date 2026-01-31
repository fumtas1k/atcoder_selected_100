# -
# ABC443/D
# 貪欲法
# スイープ法
# 二方向貪欲法

T = gets.to_i
ans = []
T.times do
  n = gets.to_i
  rs = gets.split.map(&:to_i)

  res = rs.dup

  # 操作は「上への移動」のみなので、値は小さくなる方向にしか変化しない
  # 左から: Ri = min(Ri, Ri-1 + 1)
  (1...n).each do |i|
    res[i] = [res[i], res[i - 1] + 1].min
  end

  # 右から: Ri = min(Ri, Ri+1 + 1)
  (n - 2).downto(0) do |i|
    res[i] = [res[i], res[i + 1] + 1].min
  end

  ans << rs.zip(res).sum { _1 - _2 }
end

puts ans
