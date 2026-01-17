# -
# ABC441/E
# 転倒数

# Sのi文字目からj文字目までを取って得られる部分文字列が条件を満たすのは Aj - Ai-1 > Bj - Bi-1
# 式変形すると Aj - Bj > Ai-1 - Bi-1
# これは転倒数を求めるのと同じ要領で解ける

N = gets.to_i
S = gets.chomp.chars
counters = Array.new(2 * N + 1, 0)
counters[N] = 1

diff = N
ans = 0
sum = 0 # diffより小さい位置にある数の合計
S.each do |s|
  case s
  when "A"
    # 更新される diff より小さい位置にある数を加算
    sum += counters[diff]
    diff += 1
  when "B"
    diff -= 1
    # 更新されたdiff と同じ位置にある数は減算
    sum -= counters[diff]
  end
  counters[diff] += 1
  ans += sum
end

puts ans
