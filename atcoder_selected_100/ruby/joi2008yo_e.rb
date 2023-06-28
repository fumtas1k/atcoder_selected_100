# 13
# JOI2008YO/E
# 全探索:bit全探索

R, C = gets.split.map(&:to_i)
A = Array.new(R) { gets.split.map(&:to_i) }

ans = 0
(1 << R).times do |bit|
  cnt = 0
  C.times do |j|
    temp_cnt = 0
    R.times do |i|
      temp_cnt += A[i][j] ^ bit[i]
    end
    cnt += [temp_cnt, R - temp_cnt].max
  end
  ans = [ans, cnt].max
end

puts ans
