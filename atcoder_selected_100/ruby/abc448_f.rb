# -
# ABC448/F
# 数学的な問題
# Mo’s algorithm風蛇行ソート
# ハミルトンサイクル

M = 2e7

N = gets.to_i
X = Array.new(N)
Y = Array.new(N)
N.times do |i|
  X[i], Y[i] = gets.split.map(&:to_i)
end

# Mo’s algorithmのブロックサイズ
B = (M / Math.sqrt(N)).to_i

sorted = (0...N).sort do |i, j|
  bxi = X[i] / B
  bxj = X[j] / B

  next bxi <=> bxj if bxi != bxj

  # 蛇行(ジグザグ)にするため、ブロックの偶奇でYの比較を変える
  bxi.even? ? Y[i] <=> Y[j] : Y[j] <=> Y[i]
end

idx0 = sorted.index(0)
# 0を先頭に持ってくるために回転させる
ans = sorted.rotate!(idx0).map(&:succ)

puts ans.join(" ")
