#!/bin/bash

# 用法: ./new_day.sh 5 "Merge Two Sorted Lists"

DAY_NUM=$1
TITLE=$2

# 檢查參數
if [ -z "$DAY_NUM" ] || [ -z "$TITLE" ]; then
  echo "用法: $0 <DayNumber> \"<題目名稱>\""
  exit 1
fi

# 建立目錄
DIR="day$(printf "%02d" $DAY_NUM)"
mkdir -p $DIR

# 建立 README.md
cat > $DIR/README.md <<EOF
# Day $DAY_NUM - 刷題紀錄

## 題目
- 題號： (請填寫)
- 題目連結：[LeetCode - $TITLE]()

## 思路
1. (請填寫解題思路)

## 程式碼
\`\`\`cpp
// 請填寫程式碼
\`\`\`

## 測試結果
- 提交狀態：
- 執行時間：
- 記憶體用量：

## 心得
- (請填寫)
EOF

echo "已建立 $DIR/README.md"
