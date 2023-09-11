//
//  main.swift
//  DynamicArray
//
//  Created by min Lee  on 2023/8/31.
//  Copyright © 2023年 min Lee. All rights reserved.
//

import Foundation

struct DynamicArray<T: Equatable> {
    private var elements: [T]
    
    init() {
        elements = [T]()
    }
    
    var count: Int {
        return elements.count
    }
    
    var isEmpty: Bool {
        return elements.isEmpty
    }
    
    subscript(index: Int) -> T {
        get {
            assert(index < count, "Index out of range")
            return elements[index]
        }
        set {
            assert(index < count, "Index out of range")
            elements[index] = newValue
        }
    }
    
    mutating func append(_ element: T) {
        elements.append(element)
    }
    
    mutating func insert(_ element: T, at index: Int) {
        assert(index <= count, "Index out of range")
        elements.insert(element, at: index)
    }
    
    mutating func remove(at index: Int) {
        assert(index < count, "Index out of range")
        elements.remove(at: index)
    }
    
    mutating func removeAll() {
        elements.removeAll()
    }
    
    func contains(_ element: T) -> Bool {
        return elements.contains(element)
    }


    func indexOf(_ element: T) -> Int? {
        return elements.firstIndex(of: element)
    }
    
    func first() -> T? {
        return elements.first
    }
    
    func last() -> T? {
        return elements.last
    }
    
    func filter(_ isIncluded: (T) -> Bool) -> [T] {
        return elements.filter(isIncluded)
    }
    
    func map<U>(_ transform: (T) -> U) -> [U] {
        return elements.map(transform)
    }
    
    func reduce<U>(_ initialResult: U, _ nextPartialResult: (U, T) -> U) -> U {
        return elements.reduce(initialResult, nextPartialResult)
    }
}


var array = DynamicArray<Int>()
array.append(1)
array.append(2)
array.append(3)

print(array.count)     // 输出: 3
print(array[1])        // 输出: 2

array.insert(4, at: 1)
print(array.count)     // 输出: 4
print(array[1])        // 输出: 4

array.remove(at: 2)
print(array.count)     // 输出: 3
print(array[2])        // 输出: 3

//print(array.first(),array.last()) //Optional(1) Optional(3)

let filteredArray = array.filter { $0 > 2 }
print(filteredArray)  // 输出: [4, 3]

//print(array.contains(4),array.indexOf(4))   // 输出: true Optional(1)
array.removeAll()
print(array.isEmpty)   // 输出: true



