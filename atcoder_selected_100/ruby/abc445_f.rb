# -
# ABC445/F
# 数学的問題
# min-plus半環
# 繰り返し二乗法

INF = 1 << 60
N, K = gets.split.map(&:to_i)
c = Array.new(N) { gets.split.map(&:to_i) }

# a 回移動した結果と b 回移動した結果から a + b 回移動した結果を求める
prod = -> (lhs, rhs) do
  ret = Array.new(N) { [INF] * N }

  N.times do |k|
    N.times do |i|
      N.times do |j|
        ret[i][j] = [ret[i][j], lhs[i][k] + rhs[k][j]].min
      end
    end
  end
  ret
end

ans = c.map(&:dup)
k = K - 1

# 繰り返し二乗法
while k > 0
  if k[0] == 1
    ans = prod.(ans, c)
  end
  c = prod.(c, c)
  k >>= 1
end

puts N.times.map { ans[_1][_1] }
