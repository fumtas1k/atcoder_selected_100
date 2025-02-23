# -
# ABC394/F
# 動的計画法:木DP

N = gets.to_i
G = Array.new(N) { [] }

(N - 1).times do
  a, b = gets.split.map(&:to_i).map(&:pred)
  G[a] << b
  G[b] << a
end

ans = -1
dfs = ->(pos = 0, pre = -1) do
  res = 1
  d = []
  G[pos].each do |to|
    next if to == pre
    d << dfs.(to, pos)
  end
  return res if d.empty?

  d.sort!.reverse!
  res += d[0, 3].sum if d.size >= 3
  # posが次数4の頂点とした場合
  ans = [ans, res + d[3]].max if d.size >= 4
  # posが次数1の葉とした場合
  # 連結した頂点は次数4である必要がある
  ans = [ans, d[0] + 1].max if d[0] > 1
  res
end

dfs.()
puts ans
