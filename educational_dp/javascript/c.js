// C

const input = require("fs").readFileSync("/dev/stdin", "utf-8").split("\n");
const N = Number(input[0]);
const  ABC = input.slice(1, 1 + N).map(str => str.split(" ").map(Number));

const dp = new Array(N + 1).fill().map(() => new Array(3).fill(0));

for (let i = 0; i < N; i++) {
  for (let j = 0; j < 3; j++) {
    for (let k = 0; k < 3; k++) {
      if (j === k) continue;
      dp[i + 1][j] = Math.max(dp[i + 1][j], dp[i][k] + ABC[i][j]);
    }
  }
}

console.log(Math.max(...dp[N]));
