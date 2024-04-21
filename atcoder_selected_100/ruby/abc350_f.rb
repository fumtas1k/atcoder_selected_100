# -
# ABC350/F
# 深さ優先探索

S = gets.chomp.chars

# 括弧の位置を記録
@brackets = Hash.new
stack = []
S.each_with_index do |s, i|
  case s
  when "("
    stack << i
  when ")"
    l = stack.pop
    @brackets[i] = l
    @brackets[l] = i
  end
end

@ans = ""

# l文字目からr文字目までを処理
# d = 0の場合順方向、 1の場合反転して逆方向から処理
def dfs(l, r, d)
  if d == 0
    i = l
    while i <= r
      case S[i]
      when "("
        dfs(i + 1, @brackets[i] - 1, 1)
        i = @brackets[i] + 1
      when /\w/
        @ans << S[i]
        i += 1
      end
    end
  else
    i = r
    while i >= l
      case S[i]
      when ")"
        dfs(@brackets[i] + 1, i - 1, 0)
        i = @brackets[i] - 1
      when /\w/
        # 括弧で囲まれいている回数が奇数回の場合大文字小文字を反転
        @ans << S[i].swapcase
        i -= 1
      end
    end
  end
end

dfs(0, S.size - 1, 0)

puts @ans
