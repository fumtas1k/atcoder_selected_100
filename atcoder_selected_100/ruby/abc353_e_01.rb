# -
# ABC353/E
# Trie木

N = gets.to_i
S = gets.chomp.split.sort

def dfs(words, idx)
  cnt = 0
  char_to_words = words.filter { idx < _1.size }.group_by { _1[idx] }
  char_to_words.each do |_, words2|
    cnt += words2.size * (words2.size - 1) / 2
    cnt += dfs(words2, idx + 1)
  end
  cnt
end

puts dfs(S, 0)
