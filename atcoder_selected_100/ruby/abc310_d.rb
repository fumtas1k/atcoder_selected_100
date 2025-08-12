# -
# ABC310/D
# ビット全探索
# 深さ優先探索

N, T, M = gets.split.map(&:to_i)
hates = Array.new(N, 0)
M.times do
  a, b = gets.split.map(&:to_i).map(&:pred)
  hates[a] |= 1 << b
  hates[b] |= 1 << a
end

ans = 0
teams = []
dfs = ->(pos) do
  if pos == N
    ans += 1 if teams.size == T
    return
  end
  # 既存チームに pos 番目の選手を追加する場合
  teams.each_with_index do |team, i|
    # tの選手の中に pos 番目の選手と相性が悪い選手がいた場合は除外
    next if hates[pos] & team > 0
    teams[i] |= 1 << pos
    dfs.(pos + 1)
    teams[i] &= ~(1 << pos)
  end
  next if teams.size == T
  # 新たなチームを作り pos番目の選手を追加する場合
  teams << (1 << pos)
  dfs.(pos + 1)
  teams.pop
end

dfs.(0)

puts ans
