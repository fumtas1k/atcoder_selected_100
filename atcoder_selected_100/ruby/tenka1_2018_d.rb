# 100
# TENKA12018/D
# 数学的問題
# 完全グラフ

N = gets.to_i

# 頂点数が k, 辺の数が N　の完全グラフが存在するかどうかを判定する
k = -1

1.upto(N + 1) do |i|
  if i * (i - 1) / 2 == N
    k = i
    break
  end
end

if k.negative?
  puts "No"
  exit
end

cnt = 0
S = Array.new(k) { [] }
k.times do |i|
  (i + 1).upto(k - 1) do |j|
    cnt += 1
    S[i] << cnt
    S[j] << cnt
  end
  S[i] = [S[i].size, *S[i]]
end

puts "Yes"
puts S.size
puts S.map { _1.join(" ") }
