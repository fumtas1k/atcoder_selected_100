# 88
# JOI2008HO/A
# 圧縮

N = gets.to_i
C = Array.new(N) { gets.to_i }

stones = [[C[0], 1]]

1.upto(N - 1) do |i|
  clr, cnt = stones.pop
  if C[i] == clr
    stones << [clr, cnt + 1]
  else
    # 配列が0始まりなので偶奇が逆になる
    if i.odd?
      if stones.empty?
        stones << [C[i], cnt + 1]
      else
        stones[-1][1] += cnt + 1
      end
    else
      stones << [clr, cnt]
      stones << [C[i], 1]
    end
  end
end

puts stones.filter { _1[0].zero? }.sum { _1[1] }
