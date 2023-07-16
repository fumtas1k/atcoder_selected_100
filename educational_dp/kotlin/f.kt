// F

fun main() {
  val S = readLine()!!.toList()
  val T = readLine()!!.toList()
  val dp = MutableList(S.size + 1) { MutableList(T.size + 1) { 0 } }

  S.forEachIndexed { i, s ->
    T.forEachIndexed {  j, t ->
      dp[i + 1][j + 1] = Math.max(dp[i + 1][j], dp[i][j + 1])
      if (s == t) {
        dp[i + 1][j + 1] = Math.max(dp[i + 1][j + 1], dp[i][j] + 1)
      }
    }
  }

  var ans = ""
  var i = S.size - 1
  var j = T.size - 1
  while (i >= 0 && j >= 0) {
    if (dp[i + 1][j + 1] == dp[i][j + 1]) {
      i--
    } else if (dp[i + 1][j + 1] == dp[i + 1][j]) {
      j--
    } else {
      ans += S[i]
      i--
      j--
    }
  }
  println(ans.reversed())
}
