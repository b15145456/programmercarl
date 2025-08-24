## 代碼隨想錄算法訓練營第一天 | 704. Binary Search、27. Remove Element、977. Squares of a Sorted Array

### 今日任務
- 主題：Array Part01
- 了解一下数组基础，以及数组的内存空间地址，数组也没那么简单。

---

## 704. Binary Search
先把 704写熟练，要熟悉 根据 左闭右开，左闭右闭 两种区间规则 写出来的二分法。

- [題目連結](https://leetcode.com/problems/binary-search/)
- [文章講解](https://programmercarl.com/0704.%E4%BA%8C%E5%88%86%E6%9F%A5%E6%89%BE.html)
- [影片講解](https://www.bilibili.com/video/BV1fA4y1o715)

#### 思路
##### 使用前提
* 数组必须有序（升序或降序皆可）。
* 数组中无重复元素。
* 如果有重复元素，二分查找返回的下标可能不唯一。
满足上述条件时，可以考虑使用 二分查找。

##### 區間定義
1. 左闭右闭区间 [left, right]
初始范围：left = 0, right = n - 1
循环条件：while (left <= right)
收缩方式：
mid = (left + right) / 2
如果目标值小于 nums[mid]，则 right = mid - 1
如果目标值大于 nums[mid]，则 left = mid + 1

2. 左闭右开区间 [left, right)
初始范围：left = 0, right = n
循环条件：while (left < right)
收缩方式：
mid = (left + right) / 2
如果目标值小于 nums[mid]，则 right = mid
如果目标值大于 nums[mid]，则 left = mid + 1

#### 程式碼
##### 左閉右閉
```cpp
class Solution {
public:
    int search(vector<int>& nums, int target) {
        int left = 0;
        int right = nums.size() - 1;
        while (left <= right) {
            int middle = left + ((right - left) / 2);       //這種寫法能避免溢位
            if (nums[middle] > target) {
                right = middle - 1;
            } else if (nums[middle] < target) {
                left = middle + 1;
            } else {
                return middle;
            }
        }
        return -1;
    }
};
```

##### 左閉右開
```cpp
class Solution {
public:
    int search(vector<int>& nums, int target) {
        int left = 0;
        int right = nums.size();
        while (left < right) {
            int middle = left + ((right - left) >> 1);      //這種寫法能避免溢位
            if (nums[middle] > target) {
                right = middle;
            } else if (nums[middle] < target) {
                left = middle + 1;
            } else {
                return middle;
            }
        }

        return -1;
    }
};
```

#### 複雜度分析
Time Complexity: O(log n)
Space Complexity: O(1)

#### 心得
- 一開始決定用怎樣的區間定義 後面就要遵守這個定義


## 27. Remove Element
 暴力的解法，可以锻炼一下我们的代码实现能力，建议先把暴力写法写一遍。 
 双指针法 是本题的精髓，今日需要掌握，至于拓展题目可以先不看

- [題目連結](https://leetcode.com/problems/remove-element/description/)
- [文章講解](https://programmercarl.com/0027.%E7%A7%BB%E9%99%A4%E5%85%83%E7%B4%A0.html)
- [影片講解](https://www.bilibili.com/video/BV12A4y1Z7LP)

#### 思路
- 数组的元素在内存地址中是连续的，不能单独删除数组中的某个元素，只能覆盖。
- 
##### 雙指針
双指针法（快慢指针法）： 通过一个快指针和慢指针在一个for循环下完成两个for循环的工作。
快指针：用來寻找新数组的元素 ，新数组就是不含有目标元素的数组
慢指针：用來建構新的數組，指向更新 新数组下标的位置，

#### 程式碼
```cpp
class Solution {
public:
    int removeElement(vector<int>& nums, int val) {
        int slowIndex = 0;
        for (int fastIndex = 0; fastIndex < nums.size(); fastIndex++) {
            if (val != nums[fastIndex]) {
                nums[slowIndex] = nums[fastIndex];
                slowIndex++;                      
                // 上面兩行可以寫成這樣 nums[slowIndex++] = nums[fastIndex];
            }
        }
        return slowIndex;
    }
};
```

#### 複雜度分析
Time Complexity: O(n) due to ...
Space Complexity: O(1) due to ...

#### 心得
- 這道題作為雙指針的概念訓練非常重要


## 977. Squares of a Sorted Array
本题关键在于理解双指针思想

- [題目連結](https://leetcode.com/problems/squares-of-a-sorted-array/)
- [文章講解](https://programmercarl.com/0977.%E6%9C%89%E5%BA%8F%E6%95%B0%E7%BB%84%E7%9A%84%E5%B9%B3%E6%96%B9.html)
- [影片講解](https://www.bilibili.com/video/BV1QB4y1D7ep/?vd_source=3f53d2627760bd7c20a18f38eb11cb0f)

#### 思路
数组其实是有序的， 只不过负数平方之后可能成为最大数了。
那么数组平方的最大值就在数组的两端，不是最左边就是最右边，不可能是中间。
此时可以考虑双指针法了，i指向起始位置，j指向终止位置。
定义一个新数组result，和A数组一样的大小，让k指向result数组终止位置。
如果A[i] * A[i] < A[j] * A[j] 那么result[k--] = A[j] * A[j]; 。
如果A[i] * A[i] >= A[j] * A[j] 那么result[k--] = A[i] * A[i]; 。

#### 程式碼
```cpp
class Solution {
public:
    vector<int> sortedSquares(vector<int>& A) {
        int k = A.size() - 1;
        vector<int> result(A.size(), 0);
        for (int i = 0, j = A.size() - 1; i <= j;) { 
            if (A[i] * A[i] < A[j] * A[j])  {
                result[k--] = A[j] * A[j];
                j--;
            }
            else {
                result[k--] = A[i] * A[i];
                i++;
            }
        }
        return result;
    }
};
```

#### 複雜度分析
Time Complexity: O(n) due to 因為每個元素最多被處理一次。
Space Complexity: O(n) due to 因為需要一個新的陣列來存放平方後並排序的結果。

#### 心得
- (請填寫)

