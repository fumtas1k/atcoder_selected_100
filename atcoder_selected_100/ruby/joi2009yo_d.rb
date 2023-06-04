# 27
# JOI2009YO/D
# 深さ優先探索

M = gets.to_i
N = gets.to_i
A = Array.new(N) { gets.split.map(&:to_i) }

@ans = 0
def dfs(i, j, depth)
  if A[i][j] == 0
    @ans = [depth, @ans].max
    return
  end

  A[i][j] = 0
  [[0, 1], [1, 0], [0, -1], [-1, 0]].each do |di, dj|
    ni, nj = i + di, j + dj
    next if !ni.between?(0, N - 1) || !nj.between?(0, M - 1)
    dfs(ni, nj, depth + 1)
  end
  A[i][j] = 1
end

N.times do |i|
  M.times do |j|
    dfs(i, j, 0)
  end
end

puts @ans
