workflow "New workflow" {
  on = "pull_request"
  resolves = ["Auto Close"]
}

action "Auto Close" {
  uses = "superbrothers/auto-close-action@v0.0.1"
  env = {
    COMMENT = "このリポジトリはプルリクエストを受け付けておりません。お問い合わせは、 https://www.oreilly.co.jp/feedback/ からお願いいたします。"
  }
  secrets = ["GITHUB_TOKEN"]
}
