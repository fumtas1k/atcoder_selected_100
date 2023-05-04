# 11
# ABC128/C
# 全探索:ビット全探索

N, M = gets.split.map(&:to_i)
KS = Array.new(M) { gets.split.map { _1.to_i - 1 } }
P = gets.split.map(&:to_i)

ans = (1 << N).times.count do |i|
  switches = N.times.map { |j| i >> j & 1 == 1 }
  M.times.all? do |j|
    KS[j][1..].count { |s| switches[s] } % 2 == P[j]
  end
end

puts ans
