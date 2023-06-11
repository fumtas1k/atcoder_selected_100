# P

M = 10 ** 9 + 7
N = gets.to_i
G = Array.new(N) { [] }
(N - 1).times do
  x, y = gets.split.map(&:to_i).map(&:pred)
  G[x] << y
  G[y] << x
end

# [white, black]
@dp = Array.new(N) { [1, 1] }
def dfs(pos, pre)
  G[pos].each do |i|
    next if i == pre
    white, black = dfs(i, pos)
    @dp[pos][0] = (@dp[pos][0] * (white + black)) % M
    @dp[pos][1] = (@dp[pos][1] * white) % M
  end
  @dp[pos]
end

puts dfs(0, -1).sum % M
