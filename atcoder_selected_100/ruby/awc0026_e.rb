# -
# AWC0026/E
# 動的計画法:その他
# 尺取法
# 単調デック
# スライド最大, 最小

N, K = gets.split.map(&:to_i)
A = gets.split.map(&:to_i)

# 変動幅が k 以下の区間の数を数える関数
def count_at_most(k)
  return 0 if k < 0
  res = 0
  l = 0
  min_dq = []
  max_dq = []
  A.each_with_index do |a, r|
    # 先に a を追加
    min_dq.pop while !min_dq.empty? && A[min_dq[-1]] >= a
    max_dq.pop while !max_dq.empty? && A[max_dq[-1]] <= a
    min_dq << r
    max_dq << r

    # 変動幅が k を超えている間、左端を縮める
    while A[max_dq[0]] - A[min_dq[0]] > k
      l += 1
      min_dq.shift if min_dq[0] < l
      max_dq.shift if max_dq[0] < l
    end

    res += r - l + 1
  end
  res
end

puts count_at_most(K) - count_at_most(K - 1)

