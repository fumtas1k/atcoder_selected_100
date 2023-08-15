// J

fun solve() {
  val N = readLine()!!.toInt()
  // withDefaultを使用することで、getValueで値がない時のdefault値を設定できる
  val A = readLine()!!.split(" ").map(String::toInt).groupingBy { it }.eachCount().withDefault { 0 }


  // DP[i][j][k] := 3個の皿の数i, 2個の皿の数j, 1個の皿の数k, 0個の皿の数N-i-j-kの時の操作回数の期待値
  // 求める値はDP[A[3]][A[2]][A[1]]
  // DP[i][j][k] = (DP[i][j][k]*(N-i-j-k)/N + DP[i-1][j+1][k]*i/N + DP[i][j-1][k+1]*j/N + DP[i][j][k-1]*k/N) + 1
  // 変形すると
  // DP[i][j][k] = (DP[i-1][j+1][k] + DP[i][j-1][k+1] + DP[i][j][k-1] + N) / (i+j+k)
  // MutableListだとTLEになるので、DoubleArrayを使用する
  val DP = Array(N + 1) { Array(N + 1) { DoubleArray(N + 1) { -1.0 } } }
  DP[0][0][0] = 0.0

  fun dfs(i: Int, j: Int, k: Int): Double {
    if (DP[i][j][k] >= 0.0) return DP[i][j][k]
    var exp = N.toDouble()
    if (i > 0) exp += dfs(i - 1, j + 1, k) * i
    if (j > 0) exp += dfs(i, j - 1, k + 1) * j
    if (k > 0) exp += dfs(i, j, k - 1) * k
    DP[i][j][k] = exp / (i + j + k)
    return DP[i][j][k]
  }
  println(dfs(A.getValue(3), A.getValue(2), A.getValue(1)))
}

fun main() {
  Thread(null, ::solve, "solve", 1.shl(26)).start()
}
