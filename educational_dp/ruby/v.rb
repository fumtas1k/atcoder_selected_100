# V

N, M = gets.split.map(&:to_i)
G = Array.new(N) { [] }
(N - 1).times do
  x, y = gets.split.map(&:to_i).map(&:pred)
  G[x] << y
  G[y] << x
end

@dp = [0] * N
# posが黒色でかつ、黒色の頂点が全て連結である組み合わせを求める
def dfs1(pos, pre = -1)
  return @dp[pos] unless @dp[pos].zero?
  @dp[pos] = 1
  return @dp[pos] if G[pos] == [pre]
  G[pos].each do |i|
    next if i == pre
    # 1加算するのはpos以外白色だった場合を考慮
    @dp[pos] *= dfs1(i, pos) + 1
    @dp[pos] %= M
  end
  @dp[pos]
end

@ans = [0] * N
def dfs2(pos, pre = -1)
  @ans[pos] = 1
  G[pos].each do |i|
    @ans[pos] *= @dp[i] + 1
    @ans[pos] %= M
  end

  n = G[pos].size
  # l_cproduct, r_cproduct は累積積
  l_cproduct = []
  r_cproduct = []
  G[pos].each_with_index do |u, i|
    l_cproduct[i] = r_cproduct[i] = @dp[u] + 1
  end

  1.upto(n - 1) do |i|
    l_cproduct[i] *= l_cproduct[i - 1]
    l_cproduct[i] %= M
  end

  (n - 2).downto(1) do |i|
    r_cproduct[i] *= r_cproduct[i + 1]
    r_cproduct[i] %= M
  end

  G[pos].each_with_index do |u, i|
    next if u == pre
    # 親がiの場合の@dp[pos]を計算する
    @dp[pos] = 1
    @dp[pos] *= l_cproduct[i - 1] unless i.zero?
    @dp[pos] *= r_cproduct[i + 1] if i + 1 < n
    @dp[pos] %= M
    dfs2(u, pos)
  end
end

dfs1(0)
dfs2(0)
puts @ans
