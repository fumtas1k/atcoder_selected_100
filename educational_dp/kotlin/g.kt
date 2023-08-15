// G

fun main() {
  val (N, M) = readLine()!!.split(" ").map(String::toInt)
  val G = MutableList(N) { mutableListOf<Int>() }

  val arrows = IntArray(N) { 0 }
  repeat(M) {
    val (x, y) = readLine()!!.split(" ").map(String::toInt).map(Int::dec)
    G[x].add(y)
    arrows[y]++
  }

  var candidates = (0 .. N - 1).filter { arrows[it] == 0 }.toMutableList()
  val depth = IntArray(N) { 0 }

  while (!candidates.isEmpty()) {
    val pos = candidates.removeAt(0)
    G[pos].forEach {
      if (--arrows[it] == 0) candidates.add(it)
      depth[it] = Math.max(depth[it], depth[pos] + 1)
    }
  }

  println(depth.max())
}
