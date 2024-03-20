# -
# ABC282/D
# 深さ優先探索
# 二部グラフ
# 余事象

N, M = gets.split.map(&:to_i)
G = Array.new(N) { [] }

M.times do
  u, v = gets.split.map(&:to_i).map(&:pred)
  G[u] << v
  G[v] << u
end

# 組み合わせの数
def c2(n) = n * (n - 1) / 2

# 二部グラフの判定
def dfs(pos, c = 0)
  return @colors[pos] == c if @colors[pos] != -1
  @colors[pos] = c
  @cnts[c] += 1
  G[pos].each do |i|
    return false unless dfs(i, 1 - c)
  end
  true
end

# 答え = 全ての頂点の組み合わせ(辺) - すでに存在する頂点の組み合わせ(辺)　- 同じ色の頂点同士の組み合わせ(辺)
# で求まる
ans = c2(N) - M
@colors = [-1] * N
N.times do |i|
  next if @colors[i] != -1
  @cnts = [0] * 2
  (puts 0).then exit unless dfs(i)
  @cnts.each { ans -= c2(_1) }
end

puts ans
