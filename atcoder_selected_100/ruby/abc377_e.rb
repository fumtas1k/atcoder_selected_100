# -
# ABC377/E
# 数学的問題
# 鳩の巣原理
# ダブリング

# 遷移はダブリング 2 ** K
# 有向グラフとして考える
# 鳩の巣原理により、Nを超える場合は、必ずループが存在する
# それぞれの要素のループ(サイクル)の合計は、N以下である(同じサイクルは1回しかカウントしない)


N, K = gets.split.map(&:to_i)
P = gets.split.map(&:to_i).map(&:pred)

used = Array.new(N, false)
ans = []

N.times do |i|
  next if used[i]
  cycle = []
  j = i
  until used[j]
    used[j] = true
    cycle << j
    j = P[j]
  end

  shift = 2.pow(K, cycle.size)
  cycle.each_with_index do |v, k|
    ans[v] = cycle[(k + shift) % cycle.size] + 1
  end
end

puts ans.join(" ")

