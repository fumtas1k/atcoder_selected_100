# -
# ABC425/E
# 動的計画法:その他
# 組み合わせ
# パスカルの三角形

T, M = gets.split.map(&:to_i)

binom = Array.new(5001) { [0] * 5001 }
binom[0][0] = 1

# パスカルの三角形にて二項係数を前計算
1.upto(5000) do |n|
  binom[n][0] = 1
  1.upto(n) do |k|
    binom[n][k] = (binom[n - 1][k - 1] + binom[n - 1][k]) % M
  end
end

ans = T.times.map do
  _ = gets.to_i
  cs = gets.split.map(&:to_i)
  res = 1
  sum = 0
  cs.each do |c|
    sum += c
    res = res * binom[sum][c] % M
  end
  res
end

puts ans
