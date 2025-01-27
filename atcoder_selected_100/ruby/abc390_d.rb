# -
# 全探索:全列挙
# ベル数(N 個のものを分割する方法の総数を表す数)
# 深さ優先探索

N = gets.to_i
A = gets.split.map(&:to_i)

# B(12) = 4,213,597

@ans = []
def dfs(n = 0, xors = [])
  return @ans << xors.reduce(:^) if n == N

  xors.size.times do |i|
    xors[i] += A[n]
    dfs(n + 1, xors)
    xors[i] -= A[n]
  end

  xors << A[n]
  dfs(n + 1, xors)
  xors.pop
end

dfs
puts @ans.uniq.size
