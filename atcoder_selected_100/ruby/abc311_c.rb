# -
# ABC311/C
# 深さ優先探索
# 閉路を見つける

N = gets.to_i
A = gets.split.map(&:to_i).map(&:pred)

# 閉路の頂点を探す
# 有向グラフで頂点は必ずどこかの頂点へつながっているためN回以内の移動で必ず閉路の頂点に辿り着く
now = 0
N.times { now = A[now] }

@ans = []
@visited = [false] * N
def dfs(pos)
  return if @visited[pos]
  @visited[pos] = true
  @ans << pos + 1
  dfs(A[pos])
end
dfs(now)

puts [@ans.size, @ans.join(" ")]
