# -
# ABC381/C
# ランレングス圧縮

N = gets.to_i
S = gets.chomp.chars

# # ランレングス圧縮
RLE = S.chunk(&:itself).map { [_1, _2.size] }

ans = [1]
RLE.size.times.each_cons(3) do |i, j, k|
  next if RLE[i][0] != "1" || RLE[j][0] != "/" || RLE[k][0] != "2"
  next if RLE[j][1] != 1
  ans << [RLE[i][1], RLE[k][1]].min * 2 + 1
end

puts ans.max
