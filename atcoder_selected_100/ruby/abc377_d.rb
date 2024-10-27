# -
# ABC377/D
# 尺取法(で考えるが、実装は違う)

N, M = gets.split.map(&:to_i)
LR = Array.new(N) { gets.split.map(&:to_i).map(&:pred) }

# 各r毎にlの最大値+1を求める
lmax = Array.new(M, 0)

LR.each { lmax[_2] = [lmax[_2], _1 + 1].max }
(M - 1).times { lmax[_1 + 1] = [lmax[_1 + 1], lmax[_1]].max }

puts M.times.sum { _1 - lmax[_1] + 1}
