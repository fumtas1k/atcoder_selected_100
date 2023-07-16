// b

fun main() {
  val (N, K) = readLine()!!.split(" ").map(String::toInt)
  val H = readLine()!!.split(" ").map(String::toInt)

  val dp = MutableList(N) { Int.MAX_VALUE }
  dp[0] = 0

  for (i in 1 .. N - 1) {
    for (j in Math.max(0, i - K) .. i - 1) {
      dp[i] = Math.min(dp[i], dp[j] + Math.abs(H[i] - H[j]))
    }
  }

  println(dp[N - 1])
}
