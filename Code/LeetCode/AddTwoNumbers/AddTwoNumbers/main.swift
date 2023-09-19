//
//  main.swift
//  AddTwoNumbers
//
//  Created by min Lee  on 2023/9/19.
//  Copyright © 2023年 min Lee. All rights reserved.
//

import Foundation

//https://leetcode.cn/problems/add-two-numbers/

/*
 给你两个 非空 的链表，表示两个非负的整数。它们每位数字都是按照 逆序 的方式存储的，并且每个节点只能存储 一位 数字。

 请你将两个数相加，并以相同形式返回一个表示和的链表。

 你可以假设除了数字 0 之外，这两个数都不会以 0 开头。

  

 示例 1：


 输入：l1 = [2,4,3], l2 = [5,6,4]
 输出：[7,0,8]
 解释：342 + 465 = 807.
 示例 2：

 输入：l1 = [0], l2 = [0]
 输出：[0]
 示例 3：

 输入：l1 = [9,9,9,9,9,9,9], l2 = [9,9,9,9]
 输出：[8,9,9,9,0,0,0,1]
  

 提示：

 每个链表中的节点数在范围 [1, 100] 内
 0 <= Node.val <= 9
 题目数据保证列表表示的数字不含前导零
 */

class ListNode {
    var val: Int
    var next: ListNode?
    
    init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}


func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    // 创建一个虚拟的头节点，用来存储结果链表的起始位置
    let dummyHead = ListNode(0)
    // 创建一个当前节点，用来遍历和添加结果链表的节点
    var curr = dummyHead
    // 创建两个指针，分别指向两个输入链表的当前节点
    var p = l1, q = l2
    // 创建一个变量，用来存储进位值
    var carry = 0
    // 当两个输入链表都没有遍历完或者有进位值时，循环执行以下操作
    while p != nil || q != nil || carry != 0 {
        // 获取两个输入链表的当前节点的值，如果为空则为0
        let x = p?.val ?? 0
        let y = q?.val ?? 0
        // 计算两个值和进位值的和
        let sum = x + y + carry
        // 计算新的进位值，为和除以10的商
        carry = sum / 10
        // 计算新的节点值，为和除以10的余数
        let val = sum % 10
        // 创建一个新的节点，值为计算出的节点值，并将其添加到结果链表的末尾
        curr.next = ListNode(val)
        curr = curr.next!
        // 将两个输入链表的指针后移一位，如果为空则不移动
        p = p?.next
        q = q?.next
    }
    // 返回结果链表的头节点的下一个节点，即去掉虚拟头节点
    return dummyHead.next
}

// 创建链表1: 2 -> 4 -> 3
let linkedList1 = ListNode(2)
linkedList1.next = ListNode(4)
linkedList1.next?.next = ListNode(3)

// 创建链表2: 5 -> 6 -> 4
let linkedList2 = ListNode(5)
linkedList2.next = ListNode(6)
linkedList2.next?.next = ListNode(4)

// 相加结果: 7 -> 0 -> 8
let result = addTwoNumbers(linkedList1, linkedList2)

// 打印结果
var node = result
while node != nil {
    print(node!.val)
    node = node!.next
}

// 输出: 7 0 8

