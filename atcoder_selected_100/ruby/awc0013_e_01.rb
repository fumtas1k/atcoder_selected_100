# -
# AWC0013/E
# 深さ優先探索, 二部グラフ
# 最大マッチング
# ハンガリアン法

N, M = gets.split.map(&:to_i)
C = []
N.times do |i|
  _, *C[i] = gets.split.map(&:to_i)
end

assignments = Array.new(M + 1)
used = [false] * (M + 1)

dfs = ->(c) do
  C[c].each do |i|
    next if used[i]
    used[i] = true
    if !assignments[i] || dfs[assignments[i]]
      assignments[i] = c
      return true
    end
  end
  false
end

ans = 0
N.times do |c|
  used.fill(false)
  ans += 1 if dfs[c]
end

puts ans

