# -
# ABC430/E
# その他
# rolling hash

M = (1 << 61) - 1
base = 257

T = gets.to_i
ans = []
T.times do |i|
  as = gets.chomp.chars.map(&:to_i).map(&:succ)
  bs = gets.chomp.chars.map(&:to_i).map(&:succ)
  n = as.size
  rolling_hash_a = 0
  rolling_hash_b = 0
  first_base = base.pow(n - 1, M)
  n.times do |j|
    rolling_hash_a = (rolling_hash_a * base + as[j]) % M
    rolling_hash_b = (rolling_hash_b * base + bs[j]) % M
  end
  (n + 1).times do |j|
    if rolling_hash_a == rolling_hash_b
      ans << j
      break
    end
    break if j == n
    rolling_hash_a = ((rolling_hash_a - as[j] * first_base) * base + as[j]) % M
  end
  ans << -1 if ans.size == i
end

puts ans
