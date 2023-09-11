//
//  main.swift
//  LinkedList
//
//  Created by min Lee  on 2023/9/9.
//  Copyright © 2023年 min Lee. All rights reserved.
//

import Foundation

/// 定义链表节点类
class ListNode<T> {
    var value: T
    //一般而言，对于双向链表才有prev节点，这里统一加上
    var prev: ListNode<T>?
    var next: ListNode<T>?
    
    init(value: T) {
        self.value = value
        self.prev = nil
        self.next = nil
    }
}

/// 单链表
class SinglyLinkedList<T> where T: Equatable {
    private var head: ListNode<T>?
    private var tail: ListNode<T>?
    
    func append(value: T) {
        let newNode = ListNode(value: value)
        if let tailNode = tail {
            tailNode.next = newNode
        } else {
            head = newNode
        }
        tail = newNode
    }
    
    func printList() {
        var currentNode = head
        while let node = currentNode {
            print(node.value)
            currentNode = node.next
        }
    }
    
    func verifyNextOfNode(nodeValue: T, expectedNextValue: T) -> Bool {
        var currentNode = head
        while let node = currentNode {
            if node.value == nodeValue {
                if let nextNode = node.next {
                    return nextNode.value == expectedNextValue
                } else {
                    return false
                }
            }
            currentNode = node.next
        }
        return false
    }
}

// 测试示例
let linkedList = SinglyLinkedList<Int>()
linkedList.append(value: 1)
linkedList.append(value: 2)
linkedList.append(value: 3)
linkedList.printList()
let node1NextIs2 = linkedList.verifyNextOfNode(nodeValue: 1, expectedNextValue: 2)
print("Node 1's next is 2: \(node1NextIs2)")


/// 双向链表
class DoublyLinkedList<T> where T: Equatable  {
    private var head: ListNode<T>?
    private var tail: ListNode<T>?
    
    func append(value: T) {
        let newNode = ListNode(value: value)
        if let tailNode = tail {
            tailNode.next = newNode
            newNode.prev = tailNode
        } else {
            head = newNode
        }
        tail = newNode
    }
    
    func printList() {
        var currentNode = head
        while let node = currentNode {
            print(node.value)
            currentNode = node.next
        }
    }
    
    func verifyAdjacentNodes(nodeValue: T, expectedPrevValue: T, expectedNextValue: T) -> Bool {
        var currentNode = head
        while let node = currentNode {
            if node.value == nodeValue {
                if let prevNode = node.prev, let nextNode = node.next {
                    return prevNode.value == expectedPrevValue && nextNode.value == expectedNextValue
                } else {
                    return false
                }
            }
            currentNode = node.next
        }
        return false
    }
}

// 测试示例
let dlinkedList = DoublyLinkedList<Int>()
dlinkedList.append(value: 1)
dlinkedList.append(value: 2)
dlinkedList.append(value: 3)
dlinkedList.printList()
let node2PrevIs1NextIs3 = dlinkedList.verifyAdjacentNodes(nodeValue: 2, expectedPrevValue: 1, expectedNextValue: 3)
print("Node 2's next is 3, prev is 1: \(node2PrevIs1NextIs3)")


/// 循环列表
class CircularLinkedList<T> {
    private var head: ListNode<T>?
    
    func append(value: T) {
        let newNode = ListNode(value: value)
        if head == nil {
            head = newNode
            newNode.next = newNode
        } else {
            let tail = findTailNode()
            tail.next = newNode
            newNode.next = head
        }
    }
    
    private func findTailNode() -> ListNode<T> {
        var currentNode = head
        while let node = currentNode, node.next !== head {
            currentNode = node.next
        }
        return currentNode!
    }
    
    func printList() {
        var currentNode = head
        while let node = currentNode {
            print(node.value)
            currentNode = node.next
            if currentNode === head {
                break
            }
        }
    }
}

// 测试示例
let clinkedList = CircularLinkedList<Int>()
clinkedList.append(value: 1)
clinkedList.append(value: 2)
clinkedList.append(value: 3)
clinkedList.printList()



