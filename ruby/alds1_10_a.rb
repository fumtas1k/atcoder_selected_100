# 34
# ALDS1_10/A
# 動的計画法:ナップザックDP

n = gets.to_i

fib = []
(n + 1).times do |i|
  if i < 2
    fib[i] = 1
  else
    fib[i] = fib[i - 1] + fib[i - 2]
  end
end

puts fib[n]
