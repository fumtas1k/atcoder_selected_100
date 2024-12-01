# -
# 深さ優先探索
# 枝切り

N, M = gets.split.map(&:to_i)

@ans = []
def dfs(nums)
  return @ans << nums.join(" ") if nums.size == N
  pre = nums.empty? ? 1 : nums[-1] + 10
  # Nまで辿り着けない条件は試さない(枝切り)
  # つまり、i + 10 * (N - nums.size - 1) > M となるiは試さない
  pre.upto(M - 10 * (N - nums.size - 1)) do |i|
    dfs(nums << i)
    nums.pop
  end
end

dfs([])
puts @ans.size
puts @ans
