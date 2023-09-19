//
//  main.swift
//  HashTable
//
//  Created by min Lee  on 2023/9/19.
//  Copyright © 2023年 min Lee. All rights reserved.
//

import Foundation

//MARK: 链式哈希
class HashTable<Key: Hashable, Value> {
    private var buckets: [[(Key, Value)]] // 桶数组

    init(capacity: Int) {
        buckets = Array(repeating: [], count: capacity)
    }

    // 哈希函数，计算键的哈希值并返回桶的索引
    private func getIndex(forKey key: Key) -> Int {
        let hashCode = key.hashValue
        return abs(hashCode) % buckets.count
    }

    // 插入键-值对
    func setValue(_ value: Value, forKey key: Key) {
        let index = getIndex(forKey: key)
        let element = (key, value)
        buckets[index].append(element)
    }

    // 获取键对应的值
    func getValue(forKey key: Key) -> Value? {
        let index = getIndex(forKey: key)
        for (existingKey, value) in buckets[index] {
            if existingKey == key {
                return value
            }
        }
        return nil
    }
}

//MARK: 开放地址法
class HashTable2<Key: Hashable, Value> {
    private var keys: [Key?]
    private var values: [Value?]

    init(capacity: Int) {
        keys = Array(repeating: nil, count: capacity)
        values = Array(repeating: nil, count: capacity)
    }

    // 哈希函数，计算键的哈希值并返回桶的索引
    private func getIndex(forKey key: Key) -> Int {
        let hashCode = key.hashValue
        return abs(hashCode) % keys.count
    }

    // 插入键-值对
    func setValue(_ value: Value, forKey key: Key) {
        var index = getIndex(forKey: key)
        while keys[index] != nil {
            // 发生冲突，使用线性探测找到下一个可用的桶位置
            index = (index + 1) % keys.count
        }
        keys[index] = key
        values[index] = value
    }

    // 获取键对应的值
    func getValue(forKey key: Key) -> Value? {
        var index = getIndex(forKey: key)
        while let existingKey = keys[index] {
            if existingKey == key {
                return values[index]
            }
            // 继续线性探测下一个位置
            index = (index + 1) % keys.count
        }
        return nil
    }
}


//MARK: Swift中 Dictionary

var hashTable = [Int: String]()

// 插入键值对
hashTable[1] = "Apple"
hashTable[2] = "Banana"
hashTable[3] = "Orange"

// 访问和修改值
let value = hashTable[2]  // "Banana"
hashTable[3] = "Mango"

// 删除键值对
hashTable.removeValue(forKey: 1)

// 遍历哈希表
for (key, value) in hashTable {
    print("Key: \(key), Value: \(value)")
}

// 输出：
// Key: 2, Value: Banana
// Key: 3, Value: Mango

