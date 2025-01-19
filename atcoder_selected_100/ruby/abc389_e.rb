# -
# 二分探索
# 決め打ち二分探索, 最小値の最大化

N, M = gets.split.map(&:to_i)
P = gets.split.map(&:to_i)

# 1 + 3 + ... + 2k - 1 == k ** 2 であることを用いる
# (等差数列の和: k * (a1 + ak) / 2 == k * (1 + 2 * k - 1) / 2 == k ** 2)
# i 番目の商品の値段はそれぞれ異なり、j 番目(1-indexed)に安いものの値段は (2j - 1) * P[i]　円 と考える
# cost 円以下の商品を全て購入し、cost + 1 円で　残り買えるだけ買う
# 購入できる総数量を求める.
def calc_purchase_quantity(cost)
  cnt = total = 0
  P.each do |p|
    k = (cost / p + 1) / 2
    next if k.zero?
    return 0 if M / k.pow(2) / p == 0
    total += k.pow(2) * p
    return 0 if total > M
    cnt += k
  end
  cnt + (M - total) / (cost + 1)
end

ok = 0
ng = M + 1
while ng - ok > 1
  mid = (ok + ng) / 2
  calc_purchase_quantity(mid) > 0 ? ok = mid : ng = mid
end

puts calc_purchase_quantity(ok)
