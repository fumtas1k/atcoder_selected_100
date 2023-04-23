# 2
# ABC106/B
# 全探索：全列挙

N = gets.to_i
divisors = [0] * (N + 1)

1.step(N, 2) do |i|
  i.step(N, i) { divisors[_1] += 1 }
end

puts 1.step(N, 2).count { divisors[_1] == 8 }
