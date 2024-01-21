# -
# ABC337/E
# 数学的問題
# ビット

N = gets.to_i
# 必ず1本は腐っているので1本引いた本数を友人に配布し誰もお腹を壊さなければ引いたジュースが腐っていることがわかる
M = (N - 1).bit_length

friends_juices = Array.new(M) { [] }
M.times do |i|
  # i番目の友人に配るジュースは、ジュース番号のiビット目が立っている
  # N番のジュースは友人に配布しない
  1.upto(N - 1) do |bit|
    friends_juices[i] << bit if bit[i] == 1
  end
end

puts M
$stdout.flush
friends_juices.each do |juices|
  puts [juices.size, *juices].join(" ")
  $stdout.flush
end

results = gets.chomp.chars.map(&:to_i)

ans = 0
results.each_with_index do |result, i|
  next if result.zero?
  ans |= 1 << i
end

# 誰もお腹を壊していなければ、配布していないN番目のジュースが腐っている
puts ans.zero? ? N : ans
$stdout.flush
