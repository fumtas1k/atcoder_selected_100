# -
# ABC430/C
# 全探索:全列挙
# 尺取法
# 条件分離

N, A, B = gets.split.map(&:to_i)
S = gets.chomp.chars

ans = 0
ra = rb = 0
a_cnt = b_cnt = 0
S[0] == "a" ? a_cnt += 1 : b_cnt += 1
N.times do |l|
  while ra < N && a_cnt < A
    ra += 1
    a_cnt += 1 if S[ra] == "a"
  end
  while rb < N && b_cnt < B
    rb += 1
    b_cnt += 1 if S[rb] == "b"
  end
  ans += [0, rb - ra].max

  S[l] == "a" ? a_cnt -= 1 : b_cnt -= 1
end

puts ans
