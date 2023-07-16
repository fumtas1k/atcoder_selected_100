// C

fun main() {
  val N = readLine()!!.toInt()
  val ABC = MutableList(N) { readLine()!!.split(" ").map(String::toInt) }

  val dp = MutableList(N + 1) { MutableList(3) { 0 } }

  for ((i, abc) in ABC.withIndex()) {
    for (j in 0 .. 2) {
      for (k in 0 .. 2) {
        if (j == k) continue
        dp[i + 1][j] = Math.max(dp[i + 1][j], dp[i][k] + abc[j])
      }
    }
  }

  println(dp[N].max())
}
