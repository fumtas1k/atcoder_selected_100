// H

fun main() {
  val M = 1_000_000_007
  val (H, W) = readLine()!!.split(" ").map(String::toInt)
  val A = MutableList(H) { readLine()!!.toList() }
  val dp = MutableList(H) { MutableList(W) { 0 } }
  dp[0][0] = 1

  repeat(H) { i ->
    repeat(W) next@ { j ->
      if (A[i][j] == '#') return@next
      if (i > 0) dp[i][j] = (dp[i][j] + dp[i - 1][j]) % M
      if (j > 0) dp[i][j] = (dp[i][j] + dp[i][j - 1]) % M
    }
  }

  println(dp[H - 1][W - 1])
}
