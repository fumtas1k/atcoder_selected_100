# -
# ABC444/E
# 全探索:全列挙
# 尺取法
# 順序付き集合

require "rbtree"

N, D = gets.split.map(&:to_i)
A = gets.split.map(&:to_i)

INF = 10**18

sorted_set = RBTree.new

# 番兵
sorted_set[-INF] = true
sorted_set[2*INF] = true

ans = 0
r = 0
N.times do |l|
  while r < N
    b = A[r]
    # b 以上の最小要素（正順の木で lower_bound）
    hi_key, = sorted_set.lower_bound(b)
    break if hi_key - b < D
    # b 未満の最大要素
    lo_key, = sorted_set.upper_bound(b - 1)
    break if b - lo_key < D
    sorted_set[b] = true
    r += 1
  end
  ans += r - l
  sorted_set.delete(A[l])
end

puts ans
