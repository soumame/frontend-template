#!/bin/sh

# 使い方: sh os-alert.sh "タイトル" "メッセージ"

TITLE="$1"
MESSAGE="$2"

# -------------------------------------------------------
# 1. Mac (AppleScript)
# -------------------------------------------------------
if command -v osascript >/dev/null 2>&1; then
   osascript -e 'display alert "'"$TITLE"'" message "'"$MESSAGE"'" as critical'
   exit 0
fi

# -------------------------------------------------------
# 2. Windows (PowerShell)
# -------------------------------------------------------
if command -v powershell.exe >/dev/null 2>&1; then
   # 改行コード(\n)をPowerShell用(`n)に変換
   WIN_MSG=$(echo "$MESSAGE" | sed 's/\\n/`n/g')
   # ダブルクォートのエスケープ処理
   WIN_MSG=${WIN_MSG//\"/\`\"}
   
   powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show(\"$WIN_MSG\", \"$TITLE\", 'OK', 'Warning')"
   exit 0
fi

# -------------------------------------------------------
# 3. Linux (Zenity または Notify-send)
# -------------------------------------------------------
if command -v zenity >/dev/null 2>&1; then
   # GUIダイアログが出る (Ubuntu desktop等)
   zenity --error --title="$TITLE" --text="$MESSAGE"
elif command -v notify-send >/dev/null 2>&1; then
   # 通知センターに出る
   notify-send "$TITLE" "$MESSAGE" -u critical
fi