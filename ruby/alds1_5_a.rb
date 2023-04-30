# 10
# ALDS-5/A
# 全探索:ビット全探索

N = gets.to_i
A = gets.split.map(&:to_i)
Q = gets.to_i
M = gets.split.map(&:to_i)

nums = {}

(1 << N).times do |i|
  num = 0
  N.times do |j|
    num += A[j] if i >> j & 1 == 1
  end
  nums[num] = true
end

M.each { |m| puts nums[m] ? "yes" : "no" }
