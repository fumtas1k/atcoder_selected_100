# -
# AWC0004/D
# 貪欲法
# 区間スケジューリング問題
# セグメント木

require "ac-library-rb/segtree"

N, M = gets.split.map(&:to_i)
LR = Array.new(M) { gets.split.map(&:to_i).map(&:pred) }.sort_by(&:last)
spaces = AcLibraryRb::SegTree.new([*0 ... N], N) { [_1, _2].min }

LR.each do |l, r|
  space = spaces.prod(l, r + 1)
  if space > r
    puts "No"
    exit
  end
  spaces[space] = N
end

puts "Yes"
