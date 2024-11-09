# -
# ABC379/E
# 下の桁から確定してく
# 巨大な桁数

N = gets.to_i
S = gets.chomp.chars.map(&:to_i)

csum = N.times.reduce([0]) {|acc, i| acc << acc[-1] + S[i] * (i + 1) }

ans = []
c = i = 0
while N > i || c > 0
  c += csum[N - i] if N > i
  ans << c % 10
  c /= 10
  i += 1
end

puts ans.reverse.join
