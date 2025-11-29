# -
# ABC434/D
# 累積和:いもす法
# 二次元いもす法

H = W = 2000
N = gets.to_i
UDLR = Array.new(N) { gets.split.map(&:to_i).map(&:pred) }

clouds = Array.new(H + 1) { Array.new(W + 1, 0) }
indexes = Array.new(H + 1) { Array.new(W + 1, 0) }
UDLR.each.with_index(1) do |(u, d, l, r), i|
  clouds[u][l] += 1
  clouds[u][r + 1] -= 1
  clouds[d + 1][l] -= 1
  clouds[d + 1][r + 1] += 1
  indexes[u][l] += i
  indexes[u][r + 1] -= i
  indexes[d + 1][l] -= i
  indexes[d + 1][r + 1] += i
end

(H + 1).times do |i|
  W.times do |j|
    clouds[i][j + 1] += clouds[i][j]
    indexes[i][j + 1] += indexes[i][j]
  end
end

(W + 1).times do |j|
  H.times do |i|
    clouds[i + 1][j] += clouds[i][j]
    indexes[i + 1][j] += indexes[i][j]
  end
end

cnts = Array.new(N + 1, 0)
H.times do |i|
  W.times do |j|
    if clouds[i][j].zero?
      cnts[0] += 1
    else
      # 重なりが1つだけなら、indexes[i][j]にそのインデックスが入っている
      cnts[indexes[i][j]] += 1 if clouds[i][j] == 1
    end
  end
end

puts (1 .. N).map { cnts[0] + cnts[_1] }
