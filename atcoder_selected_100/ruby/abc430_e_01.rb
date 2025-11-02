# -
# ABC430/E
# その他
# z-algorithm

require "ac-library-rb/z_algorithm"

T = gets.to_i
ans = []
T.times do |i|
  as = gets.chomp
  bs = gets.chomp
  res = AcLibraryRb::z_algorithm(bs + "$" + as + as)
  as.size.times do |j|
    if res[as.size + 1 + j] == bs.size
      ans << j
      break
    end
  end
  ans << -1 unless ans[i]
end

puts ans
