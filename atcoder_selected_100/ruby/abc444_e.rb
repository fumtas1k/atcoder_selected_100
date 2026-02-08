# -
# ABC444/E
# 全探索:全列挙
# 尺取法
# Fenwick Tree

require "ac-library-rb/fenwick_tree"

class AcLibraryRb::FenwickTree
  # 累積和が k 以上となる最小のインデックスを返す。
  #
  # @param k [Integer] 1始まりの順位 (1 <= k <= sum(size))
  # @return [Integer] k 番目要素の 0 始まりインデックス
  def kth(k)
    idx = 0
    # 2冪のdataの値は、そこまでの累積和. @size以内の最大の2冪を使用する
    bw = 1 << (@size.bit_length - 1)
    while bw > 0
      next_idx = idx + bw
      # k以上となる最小位置を返すため、累積和がk未満の最大位置を探す"<"条件を用いる
      if next_idx <= @size && @data[next_idx] < k
        idx = next_idx
        k -= @data[idx]
      end
      bw >>= 1
    end
    #　dataは、1-indexedなので、0-indexedで考えれば k以上となる最小値のindexとなる
    idx
  end
end

N, D = gets.split.map(&:to_i)
A = gets.split.map(&:to_i)

# @type [Array<Integer>]  # 座圧用の昇順ユニーク配列
vals = A.uniq.sort
# @type [Hash{Integer=>Integer}]  # 値 -> 座圧インデックス
comp = vals.map.with_index.to_h
sz = vals.size

bit = AcLibraryRb::FenwickTree.new(sz)

# @type [Integer]  # 右端ポインタ
r = 0
ans = 0
N.times do |l|
  while r < N
    ar = A[r]
    idx = comp[ar]

    cnt_lt = bit.sum(idx)
    total = bit.sum(sz)

    # A[r] より大きい要素が存在する場合
    if total > cnt_lt
      # A[r] より大きい最小要素
      succ_val = vals[bit.kth(cnt_lt + 1)]
      break if succ_val - ar < D
    end

    # A[r] 以下の要素が存在する場合
    cnt_le = bit.sum(idx + 1)
    if cnt_le > 0
      # A[r] 以下の最大要素
      pred_val = vals[bit.kth(cnt_le)]
      break if ar - pred_val < D
    end

    bit.add(idx, 1)
    r += 1
  end
  bit.add(comp[A[l]], -1)
  ans += r - l
end

puts ans

