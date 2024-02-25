# U
# bitDP

N = gets.to_i
A = Array.new(N) { gets.split.map(&:to_i) }

# dp[bit: グループに属しているうさぎ] := 得点の最大値
dp = [0] * (1 << N)

# dp[bit] := bit全てが同じグループに所属していた得点で初期化
(1 << N).times do |bit|
  N.times do |i|
    next if bit[i].zero?
    (i + 1).upto(N - 1) do |j|
      next if bit[j].zero?
      dp[bit] += A[i][j]
    end
  end
end

(1 << N).times do |bit|
  start_bit = bit | bit + 1
  total_bit = start_bit
  while total_bit < (1 << N)
    dp[total_bit] = [dp[total_bit], dp[bit ^ total_bit] + dp[bit]].max
    total_bit = start_bit | total_bit + 1
  end
end

puts dp[-1]
