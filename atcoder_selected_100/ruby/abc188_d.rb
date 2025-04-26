# -
# ABC188/D
# 累積和:いもす法

N, C = gets.split.map(&:to_i)
imos = []
N.times do
  a, b, c = gets.split.map(&:to_i)
  imos << [a - 1, c]
  imos << [b, -c]
end

# sort!だと遅い
imos.sort_by!(&:first)

ans = fee = t = 0
imos.each do |x, c|
  ans += [fee, C].min * (x - t) if t != x
  t = x
  fee += c
end

puts ans
