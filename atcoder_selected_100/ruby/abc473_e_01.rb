# -
# ABC473/E
# 累積和 mod K（区間和が K の倍数 <=> 余りが等しい）
# 区間スケジューリング（最大個数）:貪欲法

N, K = gets.split.map(&:to_i)
A = gets.split.map(&:to_i)

# 累積和 mod K が等しい 2 点 (l, r) の区間和が K の倍数。
# 「重ならない区間を最大個数選ぶ」＝ 区間スケジューリングなので、
# 終端が最も早い区間から取る貪欲が最適。
# seen = 直前の切れ目以降に現れた余りの集合。重複が出た瞬間が最小の終端。
seen = { 0 => true }
sum = 0
ans = 0
A.each do |a|
  sum = (sum + a) % K
  if seen[sum]
    ans += 1
    seen = { sum => true }  # 切った位置を次の左端候補にして貼り直す
  else
    seen[sum] = true
  end
end

puts ans
