# 15
# ABC145/C
# 全探索:順列全探索

N = gets.to_i
XY = Array.new(N) { gets.split.map(&:to_i) }
COMB = []
(N - 1).times do |i|
  xi, yi = XY[i]
  (i + 1 ... N).each do |j|
    xj, yj = XY[j]
    COMB << Math.sqrt((xi - xj) ** 2 + (yi - yj) ** 2)
  end
end

puts COMB.sum / (N * (N - 1) / 2) * (N - 1)
