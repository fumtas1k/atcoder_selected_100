# 68
# NTL-1/A
# 素因数分解

N = gets.to_i
n = N
ans = []
2.upto(Math.sqrt(N).to_i) do |i|
  while n % i == 0
    ans << i
    n /= i
  end
end

ans << n if n != 1

puts "#{N}: #{ans.join(" ")}"
