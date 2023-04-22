# ABC138/D
# 深さ優先探索

N, Q = gets.split.map(&:to_i)
G = Array.new(N + 1) { [] }
(N - 1).times do
  a, b = gets.split.map(&:to_i)
  G[a] << b
  G[b] << a
end
PX = Hash.new { |h,k| h[k] = 0 }
Q.times do
  p, x = gets.split.map(&:to_i)
  PX[p] += x
end

@ans = [0] * (N + 1)
def dfs(pos, pre)
  @ans[pos] = @ans[pre] + PX[pos]
  G[pos].each do |nxt|
    next if nxt == pre
    dfs(nxt, pos)
  end
end

dfs(1, 0)

puts @ans[1..].join(" ")
