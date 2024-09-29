# -
# ABC229/D
# 全探索:全列挙
# 尺取法
# 累積和

DOT = ".".bytes[0]
S = gets.chomp.bytes
N = S.size
K = gets.to_i

dot_csum = S.reduce([0]) {|acc, s| acc << (s == DOT ? acc[-1] + 1 : acc[-1]) }

r = 0
ans = [0]
N.times do |l|
  r += 1 while r < N && dot_csum[r + 1] - dot_csum[l] <= K
  ans << r - l
end

puts ans.max
