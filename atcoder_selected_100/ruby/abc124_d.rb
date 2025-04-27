# -
# ABC124/D
# 全探索:全列挙
# 尺取法
# ランレングス圧縮(RLE)

N, K = gets.split.map(&:to_i)
S = gets.chomp.chars.chunk_while(&:==).map { [_1[0].to_i, _1.size] }

r = cnt = length = ans = 0
S.size.times do |l|
  while r < S.size && cnt + (1 - S[r][0]) <= K
    length += S[r][1]
    cnt += 1 - S[r][0]
    r += 1
  end
  ans = [ans, length].max
  length -= S[l][1]
  cnt -= 1 - S[l][0]
end

puts ans
