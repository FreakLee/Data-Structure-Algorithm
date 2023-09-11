//
//  main.swift
//  MergeSortedArrays
//
//  Created by min Lee  on 2023/9/9.
//  Copyright © 2023年 min Lee. All rights reserved.
//

import Foundation

func mergeSortedArrays(_ a: [Int], _ b: [Int]) -> [Int] {
    //结果数组
    var mergedArray = [Int]()
    //记录数组a当前位置
    var i = 0
    //记录数组b当前位置
    var j = 0
    
    // 任意数组没有遍历完
    while i < a.count && j < b.count {
        if a[i] < b[j] {
            mergedArray.append(a[i])
            i += 1
        } else {
            mergedArray.append(b[j])
            j += 1
        }
    }
    
    // 数组a有剩余，则将数组a中剩余部分追加到mergedArray数组中
    while i < a.count {
        mergedArray.append(a[i])
        i += 1
    }
    
    // 同理，数组b有剩余，则将数组b中剩余部分追加到mergedArray数组中
    while j < b.count {
        mergedArray.append(b[j])
        j += 1
    }
    
    return mergedArray
}

// 测试示例
let a = [1, 4, 6, 7]
let b = [2, 3, 5, 9]
let merged = mergeSortedArrays(a, b)
print(merged)  // 输出: [1, 2, 3, 4, 5, 6, 7, 9]

