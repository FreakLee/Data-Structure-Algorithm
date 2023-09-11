//
//  main.swift
//  LinkedListInterviews
//
//  Created by min Lee  on 2023/9/10.
//  Copyright © 2023年 min Lee. All rights reserved.
//

import Foundation

/// 定义链表节点类
class ListNode {
    var value: Int
    var next: ListNode?
    init(value: Int) {
        self.value = value
        self.next = nil
    }
}

/// 打印链表
func printLinkedList(_ head: ListNode?) {
    var currentNode: ListNode? = head
    while let node = currentNode {
        //稍微处理下 便于后面测试输出结果对比
        if node.next == nil {
            print(node.value,terminator: "\n")
        } else {
            print(node.value,terminator: " ")
        }
        currentNode = node.next
    }
}

//MARK: 链表的插入与删除节点

/// 定义链表
class LinkedList {
    var head: ListNode?
    var tail: ListNode?
    
    // 头插法
    func insertAtHead(_ value: Int) {
        let newNode = ListNode(value:value)
        
        if head == nil {
            head = newNode
            tail = newNode
        } else {
            newNode.next = head
            head = newNode
        }
    }
    
    // 尾插法
    func insertAtTail(_ value: Int) {
        let newNode = ListNode(value:value)
        
        if head == nil {
            head = newNode
            tail = newNode
        } else {
            tail?.next = newNode
            tail = newNode
        }
    }
}

// 示例使用
let linkedList = LinkedList()

// 头插法插入节点
linkedList.insertAtHead(3)
linkedList.insertAtHead(2)
linkedList.insertAtHead(1)

// 输出链表：1 -> 2 -> 3
printLinkedList(linkedList.head)

// 尾插法插入节点
linkedList.insertAtTail(4)
linkedList.insertAtTail(5)

// 输出链表：1 -> 2 -> 3 -> 4 -> 5
printLinkedList(linkedList.head)


/// 删除指定节点
/// 给定要删除的节点，直接将该节点从链表中移除。这需要修改节点前一个节点的 next 指针，将其指向要删除节点的下一个节点，从而跳过要删除的节点。
func deleteNode(_ node: ListNode) {
    if let nextNode = node.next {
        node.value = nextNode.value
        node.next = nextNode.next
    } else {
        // 要删除的节点是尾节点，无法修改前一个节点的next指针，所以只能将其置为0
        node.value = 0
    }
}

/// 删除指定值的节点
/// 给定要删除的节点值，在链表中查找该值，并删除对应的节点。
func deleteNodeWithValue(_ head: ListNode?, value: Int) -> ListNode? {
    let dummy: ListNode = ListNode(value: 0)
    dummy.next = head
    
    var prevNode: ListNode? = dummy
    var currentNode: ListNode? = head
    
    while let node = currentNode {
        if node.value == value {
            prevNode?.next = node.next
            node.next = nil
            break
        }
        
        prevNode = node
        currentNode = node.next
    }
    
    return dummy.next
}

// 创建一个示例链表
let nd1 = ListNode(value: 1)
let nd2 = ListNode(value: 2)
let nd3 = ListNode(value: 3)

nd1.next = nd2
nd2.next = nd3

// 打印原始链表
print("Before delete nd2")
// 1 2 3
printLinkedList(nd1)

// 删除节点nd2
deleteNode(nd2)

// 删除指定值为2的节点
let updateHead = deleteNodeWithValue(nd1, value: 2)
// 1 3
printLinkedList(updateHead)

// 打印删除节点后的链表
print("After delete nd2")
// 1 3
printLinkedList(nd1)

//MARK: 反转单链表

/*
 给定一个单链表的头节点，返回反转后的链表的头节点。例如，输入1->2->3->4->5，输出5->4->3->2->1。可以用递归或者迭代两种方式来实现。递归的思路是从链表的尾部开始反转，每次将当前节点的next指向前一个节点，直到到达头节点。迭代的思路是用一个prev指针记录前一个节点，一个curr指针记录当前节点，每次将curr的next指向prev，然后更新prev和curr，直到curr为空。
 */

// 递归方式反转单链表
func reverseListRecursively(_ head: ListNode?) -> ListNode? {
    // 如果链表为空或者只有一个节点，则直接返回头节点
    if head == nil || head?.next == nil {
        return head
    }
    // 递归地反转剩余的链表
    let newHead = reverseListRecursively(head?.next)
    // 将当前节点的next指向前一个节点
    head?.next?.next = head
    // 将当前节点的next置为空
    head?.next = nil
    // 返回新的头节点
    return newHead
}

// 迭代方式反转单链表
func reverseListIteratively(_ head: ListNode?) -> ListNode? {
    // 初始化前一个节点和当前节点
    var prev: ListNode? = nil
    var curr: ListNode? = head
    // 遍历链表
    while curr != nil {
        // 记录当前节点的下一个节点
        let next = curr?.next
        // 将当前节点的next指向前一个节点
        curr?.next = prev
        // 更新前一个节点和当前节点
        prev = curr
        curr = next
    }
    // 返回新的头节点，即原来的尾节点
    return prev
}

// 创建一个示例链表
let node1 = ListNode(value: 1)
let node2 = ListNode(value: 2)
let node3 = ListNode(value: 3)
let node4 = ListNode(value: 4)
let node5 = ListNode(value: 5)

node1.next = node2
node2.next = node3
node3.next = node4
node4.next = node5

// 打印原始链表
print("Before reversing")
printLinkedList(node1)

// 反转链表
//let reversedHead = reverseListRecursively(node1)
let reversedHead = reverseListIteratively(node1)

// 打印反转后的链表
print("After reversing")
printLinkedList(reversedHead)

//MARK: 合并两个有序链表

/*给定两个升序排列的单链表，返回合并后的升序排列的单链表。例如，输入1->3->5和2->4->6，输出1->2->3->4->5->6。也可以用递归或者迭代两种方式来实现。递归的思路是比较两个链表的头节点，选择较小的那个作为合并后链表的头节点，并将其next指向剩余两个链表合并后的结果。迭代的思路是用一个哨兵节点作为合并后链表的虚拟头节点，并用一个指针记录当前位置，每次比较两个链表的头节点，选择较小的那个接在指针后面，并更新指针和对应的链表头节点，直到其中一个链表为空。
 */

// 递归方式合并两个有序链表
func mergeTwoListsRecursively(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    // 如果其中一个链表为空，则返回另一个链表
    if l1 == nil {
        return l2
    }
    if l2 == nil {
        return l1
    }
    // 比较两个链表的头节点，选择较小的那个作为合并后链表的头节点，并将其next指向剩余两个链表合并后的结果
    if l1!.value < l2!.value {
        l1!.next = mergeTwoListsRecursively(l1!.next, l2)
        return l1
    } else {
        l2!.next = mergeTwoListsRecursively(l1, l2!.next)
        return l2
    }
}

// 迭代方式合并两个有序链表
func mergeTwoListsIteratively(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    // 创建一个哨兵节点作为合并后链表的虚拟头节点
    let dummy = ListNode(value: 0)
    // 用一个指针记录当前位置
    var curr: ListNode? = dummy
    // 用两个指针分别遍历两个链表
    var p1 = l1
    var p2 = l2
    // 当两个链表都不为空时，循环比较它们的头节点，选择较小的那个接在curr后面，并更新curr和对应的链表头节点
    while p1 != nil && p2 != nil {
        if p1!.value < p2!.value {
            curr?.next = p1
            p1 = p1?.next
        } else {
            curr?.next = p2
            p2 = p2?.next
        }
        curr = curr?.next
    }
    // 当其中一个链表为空时，将另一个链表的剩余部分接在curr后面
    if p1 == nil {
        curr?.next = p2
    }
    if p2 == nil {
        curr?.next = p1
    }
    // 返回合并后链表的真实头节点，即哨兵节点的next
    return dummy.next
}

// 创建两个示例链表
let n1 = ListNode(value: 1)
let n3 = ListNode(value: 3)
let n5 = ListNode(value: 5)
n1.next = n3
n3.next = n5

let n2 = ListNode(value: 2)
let n4 = ListNode(value: 4)
let n6 = ListNode(value: 6)
n2.next = n4
n4.next = n6

print("Before merging")
printLinkedList(n1)
printLinkedList(n2)

let mergedHead = mergeTwoListsRecursively(n1, n2)
//let mergedHead = mergeTwoListsIteratively(n1, n2)

print("After merging")
printLinkedList(mergedHead)

//MARK: 删除链表中倒数第n个节点

/*
 给定一个单链表和一个整数n，返回删除了倒数第n个节点后的链表。例如，输入1->2->3->4->5和n=2，输出1->2->3->5。可以用双指针法来实现。双指针法的思路是用两个指针从头节点开始遍历链表，一个快指针先走n步，然后两个指针同时走，直到快指针到达尾节点，此时慢指针指向的就是倒数第n+1个节点，将其next指向下下个节点即可删除倒数第n个节点。注意要考虑边界情况，比如n大于链表长度或者等于链表长度时，需要删除头节点。
 */

// 双指针法删除链表中倒数第n个节点
func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
    // 创建一个哨兵节点作为虚拟头节点，并将其next指向真实头节点
    let dummy = ListNode(value: 0)
    dummy.next = head
    // 初始化快慢指针，并让它们都指向哨兵节点
    var fast: ListNode? = dummy
    var slow: ListNode? = dummy
    // 让快指针先走n步
    for _ in 0..<n {
        fast = fast?.next
    }
    // 让快慢指针同时走，直到快指针到达尾节点
    while fast?.next != nil {
        fast = fast?.next
        slow = slow?.next
    }
    // 此时慢指针指向的是倒数第n+1个节点，将其next指向下下个节点即可删除倒数第n个节点
    slow?.next = slow?.next?.next
    // 返回真实头节点，即哨兵节点的next
    return dummy.next
}

// 创建一个示例链表
let no1 = ListNode(value: 1)
let no2 = ListNode(value: 2)
let no3 = ListNode(value: 3)
let no4 = ListNode(value: 4)
let no5 = ListNode(value: 5)

no1.next = no2
no2.next = no3
no3.next = no4
no4.next = no5

print("Before removing")
printLinkedList(no1)

let removed2FromEnd = removeNthFromEnd(no1, 2)

print("After removing")
printLinkedList(removed2FromEnd)


//MARK: 判断链表是否有环

//双指针判断链表是否有环
func detectCycle(_ head: ListNode?) -> ListNode? {
    var slow: ListNode? = head
    var fast: ListNode? = head
    
    // 判断链表是否有环
    while fast != nil && fast?.next != nil {
        slow = slow?.next
        fast = fast?.next?.next
        
        if slow === fast {
            // 快慢指针相遇，链表有环
            break
        }
    }
    
    if fast == nil || fast?.next == nil {
        // 链表无环
        return nil
    }
    
    // 找到环的入口节点
    slow = head
    while slow !== fast {
        slow = slow?.next
        fast = fast?.next
    }
    
    return slow
}

// 创建一个有环的示例链表
let l1 = ListNode(value: 1)
let l2 = ListNode(value: 2)
let l3 = ListNode(value: 3)
let l4 = ListNode(value: 4)
let l5 = ListNode(value: 5)

l1.next = l2
l2.next = l3
l3.next = l4
l4.next = l5
l5.next = l3 // 创建环，将尾节点指向l3

// 判断链表是否有环，并返回环的入口节点
let cycleNode = detectCycle(l1)

if let cycleNode = cycleNode {
    print("链表有环，环的入口节点值为: \(cycleNode.value)")
} else {
    print("链表无环")
}

//MARK: 链表实现LRU（Least Recently Used）缓存淘汰算法

//链表的顺序可以表示数据项的访问顺序，最近访问的数据项位于链表的头部，最久未访问的数据项位于链表的尾部。当需要淘汰缓存中的数据项时，可以选择链表尾部的节点进行删除。

/// 定义LRUCache链表节点类
class LRUCacheNode<Key, Value> {
    var key: Key
    var value: Value
    var next: LRUCacheNode<Key, Value>?
    var prev: LRUCacheNode<Key, Value>?
    
    init(key: Key, value: Value) {
        self.key = key
        self.value = value
        self.next = nil
        self.prev = nil
    }
}

/// 定义LRU缓存类
class LRUCache<Key: Hashable, Value> {
    private let capacity: Int
    private var cache: [Key: LRUCacheNode<Key, Value>]
    private var head: LRUCacheNode<Key, Value>?
    private var tail: LRUCacheNode<Key, Value>?
    
    init(capacity: Int) {
        self.capacity = capacity
        self.cache = [:]
        self.head = nil
        self.tail = nil
    }
    
    /// 获取缓存中的值
    func get(_ key: Key) -> Value? {
        if let node = cache[key] {
            moveToHead(node)
            return node.value
        }
        return nil
    }
    
    /// 插入或更新缓存中的值
    func put(_ key: Key, _ value: Value) {
        if let node = cache[key] {
            node.value = value
            moveToHead(node)
        } else {
            let newNode = LRUCacheNode(key: key, value: value)
            cache[key] = newNode
            addToHead(newNode)
            
            if cache.count > capacity {
                if let lastNode = tail {
                    removeNode(lastNode)
                    cache[lastNode.key] = nil
                }
            }
        }
    }
    
    /// 将节点移动到链表头部
    private func moveToHead(_ node: LRUCacheNode<Key, Value>) {
        if node === head {
            return
        }
        
        removeNode(node)
        addToHead(node)
    }
    
    /// 将节点添加到链表头部
    private func addToHead(_ node: LRUCacheNode<Key, Value>) {
        if head == nil {
            head = node
            tail = node
        } else {
            node.next = head
            head?.prev = node
            head = node
        }
    }
    
    /// 删除节点
    private func removeNode(_ node: LRUCacheNode<Key, Value>) {
        if node === head {
            head = node.next
        }
        
        if node === tail {
            tail = node.prev
        }
        
        node.prev?.next = node.next
        node.next?.prev = node.prev
    }
}

//使用示例

// 创建容量为 3 的 LRUCache
let cache = LRUCache<Int, String>(capacity: 3)

// 插入缓存项
cache.put(1, "Apple")
cache.put(2, "Banana")
cache.put(3, "Cherry")

// 获取缓存项
print(cache.get(2))  // 输出: Optional("Banana")

// 缓存项顺序: 2 -> 3 -> 1

cache.put(4, "Durian")

// 缓存项顺序: 4 -> 2 -> 3

print(cache.get(1))  // 输出: nil

// 缓存项顺序: 4 -> 2 -> 3

cache.put(5, "Elderberry")

// 缓存项顺序: 5 -> 4 -> 2

print(cache.get(3))  // 输出: nil

// 缓存项顺序: 5 -> 4 -> 2


