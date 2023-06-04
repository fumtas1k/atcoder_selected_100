# 52
# JOI2017YO/D
# 動的計画法:bitDP
# 累積和

N, M = gets.split.map(&:to_i)
cnt = [0] * M
csum = Array.new(M) { [0] * (N + 1) }
dp = Array.new(1 << M, Float::INFINITY)
dp[0] = 0

(1 .. N).each do |i|
  st = gets.to_i.pred
  cnt[st] += 1
  M.times do |j|
    csum[j][i] = csum[j][i - 1]
    csum[j][i] += 1 if j == st
  end
end

(1 << M).times do |i|
  pos = 0
  M.times { pos += cnt[_1] if (i >> _1) & 1 == 1 }
  M.times do |j|
    next if ((i >> j) & 1 == 1)
    dp[i + (1 << j)] = [dp[i + (1 << j)], dp[i] + cnt[j] - (csum[j][cnt[j] + pos] - csum[j][pos])].min
  end
end

puts dp[-1]
