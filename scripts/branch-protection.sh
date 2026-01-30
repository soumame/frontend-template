#!/bin/sh

# ブランチ保護スクリプト
# lefthookで実行
# 設定：禁止ブランチ
PROTECTED_BRANCHES="main master"

# 現在のブランチ取得
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

# ブランチチェック
IS_PROTECTED=0
for branch in $PROTECTED_BRANCHES; do
  if [ "$CURRENT_BRANCH" = "$branch" ]; then
    IS_PROTECTED=1
    break
  fi
done

# 禁止ブランチじゃなければ正常終了
if [ $IS_PROTECTED -eq 0 ]; then
  exit 0
fi

# -------------------------------------------------------
# ここでメッセージを定義してアラートを呼ぶ
# -------------------------------------------------------

TITLE="⚠️ オジサンからの警告 ⚠️"
MSG="アレレ〜？💦 もしかして \`$CURRENT_BRANCH\` ブランチに\nそのままプッシュしようとしちゃってるカナ⁉️😅\n\nそれはダメだゾ〜🙅‍♂️🚫\n壊れちゃったら、オジサン悲しくて泣いちゃうカモ😭💔\n\nちゃんと新しいブランチを作って、PR（プルリク）出してネ❣️\n約束ダヨ😘💕 ナンチャッテ（笑）"

# ターミナルにも出す
echo "🚫 Blocked push to '$CURRENT_BRANCH'"

# ★ここがポイント！ さっき作ったスクリプトを「道具」として使う
sh "$(dirname "$0")/alert.sh" "$TITLE" "$MSG"

# エラーで終了させてプッシュを止める
exit 1