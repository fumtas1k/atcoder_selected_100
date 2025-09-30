# -
# ABC272/E
# その他
# オーダーの見積もり

N, M = gets.split.map(&:to_i)
A = gets.split.map(&:to_i)

# 答えは明らかに0 ~ Nの範囲に収まる。これを大事な値とする
# 大事な値は、それぞれ最大で N / i 個あるので合計でも N * (1 + 1/2 + ... + 1/M) = N log N 個程度
# 各出力について線形のオーダーで答えを求めても十分高速
B = Array.new(M + 1) { [] }

A.each.with_index(1) do |a, i|
  # aがマイナスの場合は、プラスになるまで無視できる。プラスになるタイミングを調べる
  j = [0, -(a / i)].max
  a += i * j
  while a <= N && j <= M
    B[j] << a
    j += 1
    a += i
  end
end

ans = []
1.upto(M) do |i|
  B[i].sort!.uniq!
  j = 0
  j += 1 while j == B[i].shift
end

puts ans
