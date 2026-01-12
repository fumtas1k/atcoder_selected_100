# -
# ABC440/E
# その他
# 優先度付キュー, K番目

require "ac-library-rb/priority_queue"

N, K, X = gets.split.map(&:to_i)
A = gets.split.map(&:to_i).sort.reverse

# [美味しさの和, 現在位置, 一つ前の位置の選択個数, 現在位置の選択個数]
pq = AcLibraryRb::PriorityQueue.new { _1[0] > _2[0] }
pq << [A[0] * K, 0, 0, K]

ans = []
X.times do
  val, pos, pre_cnt, pos_cnt = pq.pop

  ans << val

  if pre_cnt > 0
    new_val = val - A[pos - 1] + A[pos]
    pq << [new_val, pos, pre_cnt - 1, pos_cnt + 1]
  end

  if pos < N - 1
    new_val = val - A[pos] + A[pos + 1]
    pq << [new_val, pos + 1, pos_cnt - 1, 1]
  end
end

puts ans
