# -
# ABC419/D
# 動的計画法:その他
# 長さLの連続部分列の総和がMの倍数

# A1 + ... + AL が M の倍数
# 1 ≤ i ≤ N−L なる任意の i についてAi − A(i+L) が M の倍数 -> Ai と A(i+L) の mod M が等しい

INF = 1 << 60

N, M, L = gets.split.map(&:to_i)
A = gets.split.map(&:to_i)

# 各グループの余りごとの個数をカウント
group_tally = Array.new(L) { Hash.new(0) }

A.each_with_index do |a, i|
  group_tally[i % L][a % M] += 1
end

dp = Hash.new(0)
dp[0] = 0
group_tally.each do |tally|
  ep = Hash.new(INF)
  # 各グループ毎の最適解を求めるため、候補はtallyのkeyだけ
  # 後で 帳尻を合わせるため、0 (mod M) にするための追加コストを計算する
  tally.each do |mod1, _|
    cost = tally.sum do |mod2, cnt|
      (mod1 - mod2 + M) % M * cnt
    end

    dp.each do |mod2, old_cost|
      new_mod = (mod2 + mod1) % M
      new_cost = old_cost + cost
      ep[new_mod] = [ep[new_mod], new_cost].min
    end
  end
  dp = ep
end

cnt = N / L
ans = dp.reduce(INF) do |acc, (mod, cost)|
  next acc if cost >= acc
  # 0 (mod M) にするための追加コスト
  add_cost = (M - mod) % M * cnt
  [acc, cost + add_cost].min
end

puts ans

