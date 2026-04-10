# -
# AWC0045/B
# その他
# Rolling Hash

MOD = (1 << 61) - 1

N, M = gets.split.map(&:to_i)
A = gets.split.map(&:to_i)
B = gets.split.map(&:to_i)

base = 1009

csum_rolling_a = A.reduce([0]) { |acc, x| acc << (acc[-1] * base + x) % MOD }
rolling_b = B.reduce(0) { |acc, x| (acc * base + x) % MOD }

(0 .. N - M).each do |i|
  if (csum_rolling_a[i + M] - csum_rolling_a[i] * base.pow(M, MOD)) % MOD == rolling_b
    puts i + 1
    exit
  end
end

puts -1
