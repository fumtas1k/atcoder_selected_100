# -
# AWC0038/E
# 全探索:ビット全探索
# 半分全列挙

N, M, K = gets.split.map(&:to_i)
P = gets.split.map(&:to_i)

# G[i] := 区画 i 自身 + 隣接区画のビットマスク（自分自身を含める）
G = Array.new(N) { 1 << _1 }
K.times do
  u, v = gets.split.map(&:to_i).map(&:pred)
  G[u] |= 1 << v
  G[v] |= 1 << u
end

N1 = N / 2
N2 = N - N1

# 前半の DP
mask = (1 << N1) - 1
sums = Array.new(1 << N1, 0)
(1...(1 << N1)).each do |s|
  # i = s の中で一番番号が大きい区画
  i = s.bit_length - 1
  # i を選ばない場合
  a = sums[s ^ (1 << i)]
  # i を選ぶ場合, i の隣接頂点は除外
  b = sums[s & ~G[i] & mask] + P[i]
  sums[s] = [a, b].max
end

ans = sums.max

# 後半の DP + 前半との結合
sums2 = Array.new(1 << N2, 0)
# ng[s] := 後半の集合 s に含まれる頂点たちと辺で繋がっている全頂点のマスク
ng = Array.new(1 << N2, 0)
(1...(1 << N2)).each do |s|
  i = s.bit_length - 1
  # N1下駄上げが必要
  j = i + N1
  a = sums2[s ^ (1 << i)]
  # 後半のDPでは後半内部の辺だけが関係する
  # G[j] は全体基準のビットなので、N1ビット右シフトして後半内のインデックスに変換
  b = sums2[s & ~(G[j] >> N1)] + P[j]
  sums2[s] = [a, b].max
  ng[s] = ng[s ^ (1 << i)] | G[j]
  val = sums2[s] + sums[~ng[s] & mask]
  ans = val if val > ans
end

puts [M, ans].min
