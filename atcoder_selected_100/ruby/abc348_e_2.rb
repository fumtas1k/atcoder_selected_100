# -
# ABC348/E
# 深さ優先探索
# 全方位木DP

N = gets.to_i
G = Array.new(N) { [] }
(N - 1).times do
  a, b = gets.split.map(&:to_i).map(&:pred)
  G[a] << b
  G[b] << a
end
C = gets.split.map(&:to_i)

# sum_c[v]: 頂点vの部分木に含まれるCの総和
# sum_d[v]: 頂点vの部分木について、各頂点iのC[i] * d(v, i)の総和
sum_c = Array.new(N, 0)
sum_d = Array.new(N, 0)

dfs = -> (pos, pre = -1) do
  sum_c[pos] = C[pos]
  sum_d[pos] = 0

  G[pos].each do |nex|
    next if nex == pre
    dfs.(nex, pos)
    sum_c[pos] += sum_c[nex]
    # sum(C[i] * d(pos, i)) = sum(C[i] * (d(nex, i) + 1)) = sum(C[i] * d(nex, i)) + sum(C[i])
    sum_d[pos] += sum_d[nex] + sum_c[nex]
  end
end


# f[v]: 頂点vを根としたときのf(v)の値
f = Array.new(N, 0)

# 第2段階のDFS (Rerooting): 各頂点を根としたときのf(v)を計算
# p_sum_c: vの部分木以外の頂点についてのCの総和
# p_sum_d: vの部分木以外の頂点について、C[i] * d(v, i)の総和
rerooting = ->(pos, pre = -1, p_sum_c = 0, p_sum_d = 0) do
  f[pos] = sum_d[pos] + p_sum_d

  G[pos].each do |nex|
    next if nex == pre

    # 子uから見たときの「親側」の情報を計算
    # nexの部分木以外 = 親側 + posの他の子の部分木
    nx_sum_c = p_sum_c + sum_c[pos] - sum_c[nex]
    # 距離が1増えるのでnx_sum_cを加算
    nx_sum_d = p_sum_d + sum_d[pos] - (sum_d[nex] + sum_c[nex]) + nx_sum_c

    rerooting.(nex, pos, nx_sum_c, nx_sum_d)
  end
end

dfs.(0)
rerooting.(0)

puts f.min
