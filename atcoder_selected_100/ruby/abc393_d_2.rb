# -
# ABC393/D
# マンハッタン距離の総和を最小値は、中央値

N = gets.to_i
S = gets.chomp.chars.map(&:to_i)

ones = S.filter_map.with_index { _2 if _1 == 1 }
# 1を集めるコストを最小 = マンハッタン距離の総和の最小 = 中央値に集める
mid = ones.size / 2

ans = 0
1.upto(mid) do |i|
  l = mid - i
  r = mid + i
  ans += ones[mid] - ones[l] - i if l >= 0
  ans += ones[r] - ones[mid] - i if r < ones.size
end

puts ans
