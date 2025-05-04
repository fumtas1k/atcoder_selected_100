# -
# ABC404/D
# 全探索:ビット全探索系
# 3進数で全探索

N, M = gets.split.map(&:to_i)
C = gets.split.map(&:to_i)
ZOO = Array.new(N) { [] }
M.times do |i|
  _, *a = gets.split.map(&:to_i)
  a.each do |j|
    ZOO[j - 1] << i
  end
end

ans = 1 << 60
(3.pow(N)).times do |tri|
  tri = tri.digits(3)
  animals = [0] * M
  cost = 0
  tri.each_with_index do |t, i|
    next if t.zero?
    cost += C[i] * t
    ZOO[i].each { animals[_1] += t }
  end
  next if animals.any? { _1 < 2 } || cost >= ans
  ans = cost
end

puts ans
