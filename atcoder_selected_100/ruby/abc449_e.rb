# -
# ABC449/E
# 動的計画法:その他
# フェニック木, Fenwick Tree, BIT
# 二分探索法
# クエリ先読み

require "ac-library-rb/fenwick_tree"

class AcLibraryRb::FenwickTree
  def kth(x)
    res = 0
    @step ||= 1 << (@size.bit_length - 1)
    step = @step
    while step > 0
      if res + step < @size && @data[res + step] < x
        x -= @data[res + step]
        res += step
      end
      step >>= 1
    end
    res
  end
end

N, M = gets.split.map(&:to_i)
A = gets.split.map(&:to_i).map(&:pred)

cnt = Array.new(M, 0)
N.times { cnt[A[_1]] += 1 }

# イベント方式: cnt[i]+1 のタイミングで要素 i を追加
# cnt[i] の最大値は N（極端な場合、1つの値が N 回出現）なので、cnt[i] + 1 は最大 N+1. つまり、eventsの要素数は N+2 必要
# events[i] := [イベントタイプ番号, イベントタイプ1の場合:要素番号、イベント2の場合:パーティション内の位置(1-index), クエリ番号]
# イベントタイプ番号: 1 = 追加イベント、 2 = クエリイベント
events = Array.new(N + 2) { [] }
M.times do |i|
  events[cnt[i] + 1] << [1, i]
end

# partitions[j] = j 時点で追加済みの要素数
partitions = Array.new(N + 2, 0)
(1 .. N + 1).each do |i|
  partitions[i] = partitions[i - 1] + events[i].size
end

# s[j] = j 時点での累積境界
s = Array.new(N + 2)
s[0] = N
(1 .. N + 1).each do |i|
  s[i] = s[i - 1] + partitions[i]
end

# 番兵を配置
events << []
partitions << partitions[-1]
s << (1 << 60)

Q = gets.to_i
ans = Array.new(Q)
Q.times do |i|
  x = gets.to_i
  j = s.bsearch_index { _1 >= x }
  if partitions[j].zero?
    ans[i] = A[x - 1] + 1
  else
    events[j] << [2, (x - s[j - 1] - 1) % partitions[j] + 1, i]
  end
end

ft = AcLibraryRb::FenwickTree.new(M)
events.each do |event|
  event.each do |query|
    case query
    in [1, j]
      ft.add(j, 1)
    in [2, x, i]
      ans[i] = ft.kth(x) + 1
    end
  end
end

puts ans
