# -
# ABC444/E
# 全探索:全列挙
# 尺取法
# 順序付き集合

require "rbtree"

N, D = gets.split.map(&:to_i)
A = gets.split.map(&:to_i)

INF = 10**18

# 正順の木: lower_bound(b) で b以上の最小を取得
# 逆順の木: lower_bound(-b) で -b以上の最小 = 元の値で b以下の最大を取得
fwd = MultiRBTree.new  # 正順
rev = MultiRBTree.new  # 逆順（キーを負にして格納）

# 番兵
fwd[INF] = true
rev[INF] = true  # 元の値で -INF に相当

ans = 0
r = 0

N.times do |l|
  while r < N
    b = A[r]

    # b 以上の最小要素（正順の木で lower_bound）
    hi_key, = fwd.lower_bound(b)
    break if hi_key - b < D

    # b 以下の最大要素（逆順の木で lower_bound(-b) → 元の値は符号反転）
    neg_lo_key, = rev.lower_bound(-b)
    lo_key = -neg_lo_key  # 元の値に戻す
    break if b - lo_key < D

    fwd[b] = r
    rev[-b] = r
    r += 1
  end
  ans += r - l
  fwd.delete(A[l])
  rev.delete(-A[l])
end

puts ans
