## 代碼隨想錄算法訓練營第二天 | 209. Minimum Size Subarray Sum、 59. Spiral Matrix II、 58. 區間和、 44. 開發商購買土地

### 今日任務
- 主題：Array Part02
- 學習文章：(請貼上)

---

## 209. Minimum Size Subarray Sum

- [題目連結](https://leetcode.com/problems/minimum-size-subarray-sum/description/)
- [文章講解](https://programmercarl.com/0209.%E9%95%BF%E5%BA%A6%E6%9C%80%E5%B0%8F%E7%9A%84%E5%AD%90%E6%95%B0%E7%BB%84.html)
- [影片講解](https://www.bilibili.com/video/BV1tZ4y1q7XE/)

#### 思路
本题关键在于理解滑动窗口，这个滑动窗口看文字讲解 还挺难理解的，建议大家先看视频讲解。拓展题目可以先不做。
滑動窗口實際上就是雙指針的應用，一個for循環裡面的j 指向終止位置，依照不同的條件動態調整起始位置，以滿足題目需求。
滑动窗口的精妙之处在于根据当前子序列和大小的情况，不断调节子序列的起始位置。从而将O(n^2)暴力解法降为O(n)。

#### 程式碼
```cpp
class Solution {
public:
    int minSubArrayLen(int s, vector<int>& nums) {
        int result = INT32_MAX;
        int sum = 0; // 滑动窗口数值之和
        int i = 0; // 滑动窗口起始位置
        int subLength = 0; // 滑动窗口的长度
        for (int j = 0; j < nums.size(); j++) {
            sum += nums[j];
            // 注意这里使用while，每次更新 i（起始位置），并不断比较子序列是否符合条件
            while (sum >= s) {
                subLength = (j - i + 1); // 取子序列的长度
                result = result < subLength ? result : subLength;
                sum -= nums[i++]; // 这里体现出滑动窗口的精髓之处，不断变更i（子序列的起始位置）
            }
        }
        // 如果result没有被赋值的话，就返回0，说明没有符合条件的子序列
        return result == INT32_MAX ? 0 : result;
    }
};
```

#### 複雜度分析
Time Complexity: O(n) due to ...
每个元素在滑动窗后进来操作一次，出去操作一次，每个元素都是被操作两次，所以时间复杂度是 2 × n 也就是O(n)。
Space Complexity: O(1) due to ...cccccccccccccccccccccccccccccccccccccc

#### 心得
- (請填寫)


##  59. Spiral Matrix II

- [題目連結](https://leetcode.com/problems/spiral-matrix-ii/description/)
- [文章講解](https://programmercarl.com/0059.%E8%9E%BA%E6%97%8B%E7%9F%A9%E9%98%B5II.html)
- [影片講解](https://www.bilibili.com/video/BV1SL4y1N7mV/)

#### 思路
跟二分查找類似，定義好區間。(循環不變量原則)
这四条边怎么画，每画一条边都要坚持一致的左闭右开處理原則，或者左开右闭的原则，这样这一圈才能按照统一的规则画下来。

#### 程式碼
```cpp
class Solution {
public:
    vector<vector<int>> generateMatrix(int n) {
        vector<vector<int>> res(n, vector<int>(n, 0)); // 使用vector定义一个二维数组
        int startx = 0, starty = 0; // 定义每循环一个圈的起始位置
        int loop = n / 2; // 每个圈循环几次，例如n为奇数3，那么loop = 1 只是循环一圈，矩阵中间的值需要单独处理
        int mid = n / 2; // 矩阵中间的位置，例如：n为3， 中间的位置就是(1，1)，n为5，中间位置为(2, 2)
        int count = 1; // 用来给矩阵中每一个空格赋值
        int offset = 1; // 需要控制每一条边遍历的长度，每次循环右边界收缩一位
        int i,j;
        while (loop --) {
            i = startx;
            j = starty;

            // 下面开始的四个for就是模拟转了一圈
            // 模拟填充上行从左到右(左闭右开)
            for (j; j < n - offset; j++) {
                res[i][j] = count++;
            }
            // 模拟填充右列从上到下(左闭右开)
            for (i; i < n - offset; i++) {
                res[i][j] = count++;
            }
            // 模拟填充下行从右到左(左闭右开)
            for (; j > starty; j--) {
                res[i][j] = count++;
            }
            // 模拟填充左列从下到上(左闭右开)
            for (; i > startx; i--) {
                res[i][j] = count++;
            }

            // 第二圈开始的时候，起始位置要各自加1， 例如：第一圈起始位置是(0, 0)，第二圈起始位置是(1, 1)
            startx++;
            starty++;

            // offset 控制每一圈里每一条边遍历的长度
            offset += 1;
        }

        // 如果n为奇数的话，需要单独给矩阵最中间的位置赋值
        if (n % 2) {
            res[mid][mid] = count;
        }
        return res;
    }
};```

#### 複雜度分析
Time Complexity: O(n^2) due to 模拟遍历二维矩阵的时间
Space Complexity: O(1) due to ...

#### 心得
- (請填寫)


##  58. 區間和

- [題目連結](https://kamacoder.com/problempage.php?pid=1070)
- [文章講解](https://www.programmercarl.com/kamacoder/0044.%E5%BC%80%E5%8F%91%E5%95%86%E8%B4%AD%E4%B9%B0%E5%9C%9F%E5%9C%B0.html)
- [影片講解]()

#### 思路
本题来讲解 数组 上常用的解题技巧：前缀和(prefix sum)
前缀和的思想是重复利用计算过的子数组之和，从而降低区间查询需要累加计算的次数。
前缀和 在涉及计算区间和的问题时非常有用！
下面的作法是保留一個 prefix sum陣列 做為未來用途
#### 程式碼
```cpp
#include <iostream>
#include <vector>
using namespace std;
int main() {
    int n, a, b;
    cin >> n;
    vector<int> vec(n);
    vector<int> p(n);
    int presum = 0;
    for (int i = 0; i < n; i++) {
        cin >> vec[i];
        presum += vec[i];
        p[i] = presum;
    }

    while (cin >> a >> b) {
        int sum;
        if (a == 0) sum = p[b];
        else sum = p[b] - p[a - 1];
        cout << sum << endl;
    }
}
```

#### 複雜度分析
Time Complexity: O(n+q) due to ...
Space Complexity: O(n) due to ...

#### 心得
- (請填寫)


##  44. 開發商購買土地

- [題目連結](https://kamacoder.com/problempage.php?pid=1044)
- [文章講解](https://www.programmercarl.com/kamacoder/0044.%E5%BC%80%E5%8F%91%E5%95%86%E8%B4%AD%E4%B9%B0%E5%9C%9F%E5%9C%B0.html#%E6%80%9D%E8%B7%AF)
- [影片講解]()

#### 思路
- (請填寫)

#### 程式碼
```cpp
#include <iostream>
#include <vector>
#include <climits>

using namespace std;
int main () {
    int n, m;
    cin >> n >> m;
    int sum = 0;
    vector<vector<int>> vec(n, vector<int>(m, 0)) ;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            cin >> vec[i][j];
            sum += vec[i][j];
        }
    }
    // 统计横向
    vector<int> horizontal(n, 0);
    for (int i = 0; i < n; i++) {
        for (int j = 0 ; j < m; j++) {
            horizontal[i] += vec[i][j];
        }
    }
    // 统计纵向
    vector<int> vertical(m , 0);
    for (int j = 0; j < m; j++) {
        for (int i = 0 ; i < n; i++) {
            vertical[j] += vec[i][j];
        }
    }
    int result = INT_MAX;
    int horizontalCut = 0;
    for (int i = 0 ; i < n; i++) {
        horizontalCut += horizontal[i];
        result = min(result, abs(sum - horizontalCut - horizontalCut));
    }
    int verticalCut = 0;
    for (int j = 0; j < m; j++) {
        verticalCut += vertical[j];
        result = min(result, abs(sum - verticalCut - verticalCut));
    }
    cout << result << endl;
}

```

#### 複雜度分析
Time Complexity: O(n^2) due to ...
Space Complexity: O( ) due to ...

#### 心得
- (請填寫)

