# -
# AWC0039/E
# 動的計画法:その他
# フェニック木, Fenwick Tree, BIT
# クエリ先読み

require "ac-library-rb/fenwick_tree"
include AcLibraryRb

N, M, Q, K = gets.split.map(&:to_i)

books = Array.new(M) { gets.split.map(&:to_i) }
queries = Array.new(Q) { [*gets.split.map(&:to_i), _1] }

books.sort_by!(&:last).reverse!
queries.sort_by! { _3 }.reverse!

# 棚の本の冊数を管理
fw = FenwickTree.new(N)
ans = Array.new(Q)
bi = 0

queries.each do |l, r, t, j|
  # ページ数 >= t の本をすべてFenwickTreeに追加
  while bi < M && books[bi][1] >= t
    fw.add(books[bi][0] - 1, 1)
    bi += 1
  end
  # 棚 [L, R] の本の冊数 = sum(L-1, R) (半開区間 [L-1, R))
  c = fw.sum(l - 1, r)
  ans[j] = [c - K, 0].max
end

puts ans
