#!/bin/bash

# 用法: ./new_day.sh 3 "Array Part01" "704. Binary Search,27. Remove Element,977. Squares of a Sorted Array"

DAY_NUM=$1
TOPIC=$2
QUESTIONS=$3

if [ -z "$DAY_NUM" ] || [ -z "$TOPIC" ] || [ -z "$QUESTIONS" ]; then
  echo "用法: $0 <DayNumber> \"<主題名稱>\" \"<題號. 題目, 題號. 題目, ...>\""
  exit 1
fi

# 阿拉伯數字轉中文（支援 1–20）
DAY_CHINESE=("零" "一" "二" "三" "四" "五" "六" "七" "八" "九" "十" "十一" "十二" "十三" "十四" "十五" "十六" "十七" "十八" "十九" "二十")
DAY_CN=${DAY_CHINESE[$DAY_NUM]}

# 建立目錄
DIR="day$(printf "%02d" $DAY_NUM)"
mkdir -p $DIR

# 防止覆蓋
if [ -f "$DIR/README.md" ]; then
  echo "⚠️ $DIR/README.md 已存在，未覆蓋"
  exit 1
fi

# 生成部落格標題
BLOG_TITLE="代碼隨想錄算法訓練營第${DAY_CN}天 | ${QUESTIONS//,/、}"

# 開始寫入 README.md
cat > $DIR/README.md <<EOF
# $BLOG_TITLE

## 今日任務
- 主題：$TOPIC
- 學習文章：(請貼上)

---
EOF

# 逐題生成段落
IFS=',' read -ra PROBLEMS <<< "$QUESTIONS"
for PROBLEM in "${PROBLEMS[@]}"; do
  echo "" >> $DIR/README.md
  echo "## $PROBLEM" >> $DIR/README.md
  cat >> $DIR/README.md <<'EOP'

- [題目連結]()
- [文章講解]()
- [影片講解]()

### 思路
- (請填寫)

### 程式碼
```cpp
// 請填寫
```

### 複雜度分析
Time Complexity: O( ) due to ...
Space Complexity: O( ) due to ...

### 心得
- (請填寫)

EOP
done

echo "✅ 已建立 $DIR/README.md"
echo "📌 博客標題：$BLOG_TITLE"