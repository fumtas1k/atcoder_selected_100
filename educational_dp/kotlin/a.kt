// A

fun main() {
  val N = readLine()!!.toInt()
  val H = readLine()!!.split(" ").map(String::toInt)
  val dp = MutableList(N) { Int.MAX_VALUE }
  dp[0] = 0
  for (i in 1 .. N - 1) {
    for (j in Math.max(0, i - 2) .. i - 1) {
      dp[i] = Math.min(dp[i], dp[j] + Math.abs(H[i] - H[j]))
    }
  }
  println(dp[N - 1])
}
