# -
# ABC381/D
# 全探索：全列挙
# 尺取法

N = gets.to_i
A = gets.split.map(&:to_i)

ans = 0
# 連続部分列のうち、偶数項目から始まるものと奇数項目から始まるものに分けて考える
2.times do |i|
  r = i
  used = Hash.new(false)
  i.step(N - 1, 2) do |l|
    r = [l, r].max
    while r + 1 < N && A[r] == A[r + 1] && !used[A[r]]
      used[A[r]] = true
      r += 2
    end
    ans = [ans, r - l].max
    used[A[l]] = false
  end
end

puts ans
