# -
# AWC0069/C
# 貪欲法
# 反転
# いもす法

N, K = gets.split.map(&:to_i)
S = gets.chomp.chars.map(&:to_i)

# 最も左の未確定位置から見ると、その位置に影響できる「まだ確定していない操作」は1つしかない
# -> 左から貪欲法
flip_diff = [0] * (N + 2)

ans = 0
S.each.with_index(1) do |s, i|
  flip_diff[i] += flip_diff[i - 1]
  if s == flip_diff[i] % 2 && i + K - 1 <= N
    ans += 1
    flip_diff[i] += 1
    flip_diff[i + K] -= 1
  end
  if s == flip_diff[i] % 2
    puts -1
    exit
  end
end

puts ans
