//
//  main.swift
//  TwoSum
//
//  Created by min Lee  on 2023/9/12.
//  Copyright © 2023年 min Lee. All rights reserved.
//

import Foundation

/*
 给定一个整数数组 nums 和一个整数目标值 target，请你在该数组中找出 和为目标值 target  的那 两个 整数，并返回它们的数组下标。

 你可以假设每种输入只会对应一个答案。但是，数组中同一个元素在答案里不能重复出现。

 你可以按任意顺序返回答案。

  
 示例 1：

 输入：nums = [2,7,11,15], target = 9
 输出：[0,1]
 解释：因为 nums[0] + nums[1] == 9 ，返回 [0, 1] 。
 示例 2：

 输入：nums = [3,2,4], target = 6
 输出：[1,2]
 示例 3：

 输入：nums = [3,3], target = 6
 输出：[0,1]
 */


//解题思路：利用哈希表
//哈希表可以在常数时间内查找一个元素是否存在，所以我们可以遍历数组，对于每个元素 nums[i]，我们检查 target - nums[i] 是否在哈希表中，如果在，就返回它们的下标，如果不在，就把 nums[i] 存入哈希表中，继续遍历。

func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    // 创建一个空的哈希表
    var map = [Int: Int]()
    // 遍历数组
    for i in 0..<nums.count {
        // 计算差值
        let diff = target - nums[i]
        // 检查差值是否在哈希表中
        if let j = map[diff] {
            // 如果在，返回下标
            return [j, i]
        }
        // 如果不在，把当前元素存入哈希表中
        map[nums[i]] = i
    }
    // 如果没有找到答案，返回空数组
    return []
}

//这个算法的时间复杂度是 O(n)，空间复杂度是 O(n)，其中 n 是数组的长度。

let nums = [2,7,11,15]
let target = 9

//[0, 1]
print(twoSum(nums, target))

