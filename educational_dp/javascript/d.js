// D

const input = require("fs").readFileSync("/dev/stdin", "utf-8").split("\n");
const [N, W] = input[0].split(" ").map(Number);

const dp = new Array(N + 1).fill().map(() => new Array(W + 1).fill(0));

for (let i = 1; i <= N; i++) {
  const [w, v] = input[i].split(" ").map(Number);
  for (let j = 0; j <= W; j++) {
    dp[i][j] = dp[i - 1][j];
    if (j < w) continue;
    dp[i][j] = Math.max(dp[i][j], dp[i - 1][j - w] + v);
  }
}

console.log(Math.max(...dp[N]));
