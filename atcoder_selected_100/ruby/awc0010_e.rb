# -
# AWC0010/E
# 数学的な問題
# スワップ回数(swap)
# サイクル数(cycle)

N, K = gets.split.map(&:to_i)
C = Array.new { gets.split.map(&:to_i) }

# 恒等置換から与えられた順列への最小スワップ回数を求める
#
# @param perm [Array<Integer>] 0-indexed の順列
# @return [Integer] 恒等置換から perm に変換するために必要な最小スワップ回数 (= N - サイクル数)
def min_swaps(perm)
  n = perm.size
  visited = [false] * n
  cycles = 0
  n.times do |i|
    next if visited[i]
    cycles += 1
    j = i
    until visited[j]
      visited[j] = true
      j = perm[j]
    end
  end
  n - cycles
end

# 円環配置における隣接ペアの集客効果の合計を求める
#
# @param perm [Array<Integer>] ブースへの企業の配置を表す 0-indexed の順列
# @param c [Array<Array<Integer>>] 企業間の集客効果を表す対称行列
# @return [Integer] 円環上で隣接する全ペアの集客効果の合計
def score(perm, c)
  n = perm.size
  n.times.sum { c[perm[_1]][perm[(_1 + 1) % n]] }
end

ans = 0
[*0 ... N].permutation do |perm|
  next if min_swaps(perm) > K
  s = score(perm, C)
  ans = s if s > ans
end

puts ans
