# 1
# ITP_1_7/B
# 全探索:全列挙

loop do
  n, x = gets.split.map(&:to_i)
  exit if n == 0 && x == 0

  ans = 0
  1.upto(n) do |i|
    (i + 1).upto(n) do |j|
      next unless (x - i - j).between?(j + 1, n)
      ans += 1
    end
  end
  puts ans
end
