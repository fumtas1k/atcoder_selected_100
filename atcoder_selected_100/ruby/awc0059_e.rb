# -
# AWC0059/E
# 数学的問題
# ダブリング
# LCA（Lowest Common Ancestor, 最小共通祖先）

N, Q = gets.split.map(&:to_i)

log = N.bit_length
depth = Array.new(N + 1, 0)
up = Array.new(log) { Array.new(N + 1, 0) }

# 木の構築と深さの計算
gets.split.map(&:to_i).each.with_index(2) do |p, i|
  up[0][i] = p
  # Pi < i が保証されているので必ずdepth[p]が存在する
  depth[i] = depth[p] + 1
end

# ダブリング
(1...log).each do |j|
  (1..N).each do |i|
    up[j][i] = up[j - 1][up[j - 1][i]]
  end
end

out = []
Q.times do
  x, y = gets.split.map(&:to_i)

  # 常に x の方が深く（または同じ深さに）なるようにスワップ
  x, y = y, x if depth[x] < depth[y]

  # 深さを揃える
  diff = depth[x] - depth[y]
  b = 0
  while diff > 0
    x = up[b][x] if diff.odd?
    diff >>= 1
    b += 1
  end

  # 深さを揃えた時点で一致していれば、それがLCA
  if x == y
    out << x
    next
  end

  # LCAの直前まで遡る
  (log - 1).downto(0) do |j|
    next if up[j][x] == up[j][y]
    x = up[j][x]
    y = up[j][y]
  end

  # 最後に1つ上へ移動した先がLCA
  out << up[0][x]
end

puts out
