# V
# 全方位木DP

N, M = gets.split.map(&:to_i)
G = Array.new(N) { [] }
(N - 1).times do
  x, y = gets.split.map(&:to_i).map(&:pred)
  G[x] << y
  G[y] << x
end

@size = []
# posが黒色でかつ、黒色の頂点が全て連結である組み合わせを求める
def dfs1(pos, pre = -1)
  return @size[pos] if @size[pos]
  @size[pos] = 1
  G[pos].each do |i|
    next if i == pre
    # 1加算するのはpos以外白色だった場合を考慮
    @size[pos] *= dfs1(i, pos) + 1
    @size[pos] %= M
  end
  @size[pos]
end

@ans = []
def dfs2(pos, pre = -1)
  @ans[pos] = 1
  # l_cproduct, r_cproduct は累積積
  l_cproduct = []
  r_cproduct = []
  G[pos].each_with_index do |u, i|
    @ans[pos] *= @size[u] + 1
    @ans[pos] %= M
    l_cproduct[i] = r_cproduct[i] = (@size[u] + 1) % M
  end

  n = G[pos].size
  1.upto(n - 1) do |i|
    l_cproduct[i] *= l_cproduct[i - 1]
    l_cproduct[i] %= M
  end
  (n - 2).downto(0) do |i|
    r_cproduct[i] *= r_cproduct[i + 1]
    r_cproduct[i] %= M
  end

  G[pos].each_with_index do |u, i|
    next if u == pre
    # 親がuの場合の@size[pos]を計算する
    @size[pos] = 1
    @size[pos] *= l_cproduct[i - 1] unless i.zero?
    @size[pos] *= r_cproduct[i + 1] if i < n - 1
    @size[pos] %= M
    dfs2(u, pos)
  end
end

dfs1(0)
dfs2(0)
puts @ans
