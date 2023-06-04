# 24
# ALDS1-11/B
# 深さ優先探索

n = gets.to_i
G = Array.new(n + 1) { [] }
n.times do
  u, k, *v = gets.split.map(&:to_i)
  G[u] = v
end

@d = [0]
@f = [0]
@cnt = 0

def dfs(pos)
  return if @d[pos]
  @d[pos] = (@cnt += 1)
  G[pos].each do |i|
    dfs(i)
  end
  @f[pos] = (@cnt += 1)
end

1.upto(n) do |i|
  dfs(i)
end

@d.zip(@f).each_with_index do |(d, f), i|
  next if i.zero?
  puts [i, d, f].join(" ")
end
