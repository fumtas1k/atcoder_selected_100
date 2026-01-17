# -
# ABC441/E
# 転倒数

require "ac-library-rb/fenwick_tree"

# Sのi文字目からj文字目までを取って得られる部分文字列が条件を満たすのは Aj - Ai-1 > Bj - Bi-1
# 式変形すると Aj - Bj > Ai-1 - Bi-1
# これは転倒数を求めるのと同じ要領で解ける

N = gets.to_i
S = gets.chomp.chars
bit = AcLibraryRb::FenwickTree.new(N * 2 + 1)
bit.add(N, 1)

ans = 0
diff = N
S.each do |s|
  case s
  when "A"
    diff += 1
  when "B"
    diff -= 1
  end
  bit.add(diff, 1)
  ans += bit.sum(diff)
end

puts ans
