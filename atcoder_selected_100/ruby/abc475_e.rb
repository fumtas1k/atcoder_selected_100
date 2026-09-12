# -
# ABC475/E
# ビット列への言い換え（正誤列を長さ K のビット列 = 整数にし、辞書順比較 <=> 数値の大小）
# 貪欲法（手続きの正体は「辞書順の小さい方から M 人まで通す」。N == M のときだけ例外）
# 座標圧縮・フェニック木（辞書順での順位を数えるための道具）

require "ac-library-rb/fenwick_tree"
include AcLibraryRb

# 各参加者の解答を「誤答フラグ列」X_i（j問目を間違えたら1）とみなすと、
# 予選通過の手続きは「X を辞書順に並べて小さい方から M 人まで通す」
# （同じ X の人はまとめて通すか通さないか）と同値になる。
#   => 参加者 i が通過する <=> #{j | X_j <= X_i（辞書順）} <= M
# ただし N == M のときは脱落者が出ないので、最後まで未確定で残る
# 「全問不正解 (X_i = 11...1)」の人だけが通過できない、という例外になる。
#
# X_i は長さ K のビット列 = 高々 2^200 の整数として持てば、辞書順比較 = 数値比較。
# クエリは1ビットの反転なので XOR 一発。出現しうる値は最初の N 個 + 各クエリ後の
# Q 個しかないので、オフラインで座標圧縮して Fenwick Tree で順位を数える。
N, M, K = gets.split.map(&:to_i)
T = gets.chomp.tr("ox", "01").to_i(2)
FULL = (1 << K) - 1

xs = Array.new(N) { gets.chomp.tr("ox", "01").to_i(2) ^ T }
queries = Array.new(gets.to_i) { gets.split.map(&:to_i).map(&:pred) }

# クエリを先読みして、登場する X の値をすべて集めてから座標圧縮する
cur = xs.dup
values = xs.dup
queries.each do |i, j|
  cur[i] ^= 1 << (K - j - 1)
  values << cur[i]
end
comp = values.uniq.sort.each_with_index.to_h

fwt = FenwickTree.new(comp.size)
xs.each { fwt.add(comp[it], 1) }

queries.each do |i, j|
  fwt.add(comp[xs[i]], -1)
  xs[i] ^= 1 << (K - j - 1)
  idx = comp[xs[i]]
  fwt.add(idx, 1)

  is_pass = if N == M 
    xs[i] != FULL
  else
    fwt.sum(idx + 1) <= M
  end
  puts is_pass ? "Yes" : "No"
end
