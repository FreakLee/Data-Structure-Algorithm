//
//  main.swift
//  StackAndQueue
//
//  Created by min Lee  on 2023/9/12.
//  Copyright © 2023年 min Lee. All rights reserved.
//

import Foundation

//MARK: 栈的基本操作与实现

struct Stack<T> {
    private var elements: [T] = []
    
    // 压入元素到栈顶
    mutating func push(_ element: T) {
        elements.append(element)
    }
    
    // 弹出栈顶元素并返回
    mutating func pop() -> T? {
        return elements.popLast()
    }
    
    // 查看栈顶元素
    func peek() -> T? {
        return elements.last
    }
    
    // 栈是否为空
    var isEmpty: Bool {
        return elements.isEmpty
    }
    
    // 栈的大小
    var count: Int {
        return elements.count
    }
    
    // 清空栈
    mutating func clear() {
        elements.removeAll()
    }
}

// 创建一个整数类型的栈
var intStack = Stack<Int>()

//压入元素
intStack.push(5)
intStack.push(3)
intStack.push(9)

// 弹出元素
let poppedElement = intStack.pop() // Optional(9)

// 查看栈顶元素
let topElement = intStack.peek() // Optional(3)

// 栈是否为空
let isEmpty = intStack.isEmpty // false

// 栈的大小
let stackSize = intStack.count // 2

// 清空栈
intStack.clear()


//MARK: 栈的常见应用

///表达式求值
func evaluateExpression(_ expression: String) -> Double {
    let operators: Set<Character> = ["+", "-", "*", "/"]
    var numberStack = Stack<Double>()
    var operatorStack = Stack<Character>()

    let tokens = expression.components(separatedBy: " ")

    for token in tokens {
        if let number = Double(token) {
            numberStack.push(number)
        } else if let tokenChar = token.first {
            if operators.contains(tokenChar) {
                while let topOperator = operatorStack.peek(), precedence(tokenChar) <= precedence(topOperator) {
                    performOperation(&numberStack, operatorStack.pop()!)
                }
                operatorStack.push(tokenChar)
            } else if tokenChar == "(" {
                operatorStack.push(tokenChar)
            } else if tokenChar == ")" {
                while let topOperator = operatorStack.peek(), topOperator != "(" {
                    performOperation(&numberStack, operatorStack.pop()!)
                }
                _ = operatorStack.pop() // 弹出左括号
            } else {
                fatalError("Invalid token: \(token)")
            }
        } else {
            fatalError("Invalid token: \(token)")
        }
    }

    while let operatorChar = operatorStack.pop() {
        performOperation(&numberStack, operatorChar)
    }

    guard let finalResult = numberStack.pop(), numberStack.isEmpty else {
        fatalError("Invalid expression")
    }

    return finalResult
}

func performOperation(_ numberStack: inout Stack<Double>, _ operatorToken: Character) {
    guard let operand2 = numberStack.pop(), let operand1 = numberStack.pop() else {
        fatalError("Invalid expression")
    }

    let result: Double
    switch operatorToken {
    case "+":
        result = operand1 + operand2
    case "-":
        result = operand1 - operand2
    case "*":
        result = operand1 * operand2
    case "/":
        result = operand1 / operand2
    default:
        fatalError("Invalid operator")
    }

    numberStack.push(result)
}

func precedence(_ operatorChar: Character) -> Int {
    switch operatorChar {
    case "+", "-":
        return 1
    case "*", "/":
        return 2
    default:
        return 0
    }
}

let expression = "( 5 + 3 ) * 2 - 4 / 2"
let result = evaluateExpression(expression)
print("Expression result: \(result)")


/// 括号匹配
func isParenthesesMatching(_ expression: String) -> Bool {
    let openingParentheses: Set<Character> = ["(", "[", "{"]
    let closingParentheses: Set<Character> = [")", "]", "}"]
    var stack = Stack<Character>()
    
    for char in expression {
        if openingParentheses.contains(char) {
            stack.push(char)
        } else if closingParentheses.contains(char) {
            guard let lastOpeningParenthesis = stack.pop() else {
                return false
            }
            
            let expectedOpeningParenthesis: Character
            switch char {
            case ")":
                expectedOpeningParenthesis = "("
            case "]":
                expectedOpeningParenthesis = "["
            case "}":
                expectedOpeningParenthesis = "{"
            default:
                fatalError("Invalid character")
            }
            
            if lastOpeningParenthesis != expectedOpeningParenthesis {
                return false
            }
        }
    }
    
    return stack.isEmpty
}

let expression1 = "{[()()]}"
let isMatching = isParenthesesMatching(expression1)
print(isMatching)  // true

// 括号匹配：方法二
// 定义一个函数来检查括号是否匹配
func isBalanced(_ string: String) -> Bool {
    // 创建一个存储Character类型的栈
    var stack = Stack<Character>()
    
    // 定义一个字典来存储左右括号的对应关系
    let pairs: [Character: Character] = ["(": ")", "[": "]", "{": "}"]
    
    // 遍历字符串中的每个字符
    for char in string {
        // 如果是左括号，则压入栈中
        if pairs.keys.contains(char) {
            stack.push(char)
        } else {
            // 如果是右括号，则从栈中弹出一个左括号，并检查是否匹配
            if let top = stack.pop(), pairs[top] == char {
                continue // 如果匹配，则继续遍历
            } else {
                return false // 如果不匹配，则返回false
            }
        }
    }
    
    // 遍历结束后，返回栈是否为空作为结果
    return stack.isEmpty
}

// 测试代码
let string1 = "{[()()]}"
let string2 = "{[(])}"
print("\(string1) is balanced: \(isBalanced(string1))")
print("\(string2) is balanced: \(isBalanced(string2))")

/// 浏览器历史记录
struct BrowserHistory {
    private var historyStack: Stack<String> = Stack()
    private var forwardStack: Stack<String> = Stack()
    
    mutating func visit(_ url: String) {
        historyStack.push(url)
        forwardStack.clear()
    }
    
    mutating func back() -> String? {
        if let currentURL = historyStack.pop() {
            forwardStack.push(currentURL)
            return historyStack.peek()
        }
        return nil
    }
    
    mutating func forward() -> String? {
        if let currentURL = forwardStack.pop() {
            historyStack.push(currentURL)
            return currentURL
        }
        return nil
    }
}

var browser = BrowserHistory()
browser.visit("https://www.example.com")
browser.visit("https://www.example.com/page1")
browser.visit("https://www.example.com/page2")

print("Back to Page: \(browser.back() ?? "N/A")")
print("Back to Page: \(browser.back() ?? "N/A")")
print("Forward to Page: \(browser.forward() ?? "N/A")")


//MARK: 队列的基本操作与实现

struct Queue<T> {
    private var elements: [T] = []

    mutating func enqueue(_ element: T) {
        elements.append(element)
    }

    @discardableResult mutating func dequeue() -> T? {
        if elements.isEmpty {
            return nil
        } else {
            return elements.removeFirst()
        }
    }

    @discardableResult func front() -> T? {
        return elements.first
    }

    var isEmpty: Bool {
        return elements.isEmpty
    }

    var size: Int {
        return elements.count
    }
    
    mutating func clear() {
        elements.removeAll()
    }
}

// 示例用法
var queue = Queue<Int>()

//入队
queue.enqueue(1)
queue.enqueue(2)
queue.enqueue(3)

//出队
queue.dequeue() //Optional(1)

//获取对头元素
queue.front()   // 输出: Optional(2)

//获取队列长度
print(queue.size)      // 输出: 2
//判断队列是否为空
print(queue.isEmpty)   // 输出: false
//清空队列
queue.clear()

//MARK: 队列的常见应用

//广度优先搜索（BFS）

class Node {
    var value: Int
    var neighbors: [Node]
    var visited: Bool
    
    init(value: Int, neighbors: [Node]) {
        self.value = value
        self.neighbors = neighbors
        self.visited = false
    }
}

///广度优先搜索是一种图遍历算法，常用于查找图或树中的最短路径或最小步数。队列在 BFS 中被用于存储待访问的节点，以确保按照广度的顺序进行遍历
func breadthFirstSearch(startNode: Node, targetValue: Int) -> Bool {
    var queue = Queue<Node>()
    
    queue.enqueue(startNode)
    startNode.visited = true
    
    while !queue.isEmpty {
        let currentNode = queue.dequeue()!
        
        if currentNode.value == targetValue {
            return true
        }
        
        for neighbor in currentNode.neighbors {
            if !neighbor.visited {
                queue.enqueue(neighbor)
                neighbor.visited = true
            }
        }
    }
    
    return false
}

// 示例用法
var node1 = Node(value: 1, neighbors: [])
var node2 = Node(value: 2, neighbors: [])
var node3 = Node(value: 3, neighbors: [])
var node4 = Node(value: 4, neighbors: [])
var node5 = Node(value: 5, neighbors: [])

node1.neighbors = [node2, node3]
node2.neighbors = [node4, node5]

let res = breadthFirstSearch(startNode: node1, targetValue: 5)
print(res) //true


//缓存管理

///队列在缓存管理中常用于实现 LRU（Least Recently Used，最近最少使用）策略。当缓存大小有限时，队列可以被用来存储缓存的数据项，并在缓存满时移除最早使用的数据项。
struct LRUCache<Key: Hashable, Value> {
    private let capacity: Int
    private var cache: [Key: Value]
    private var keyQueue: Queue<Key>

    init(capacity: Int) {
        self.capacity = capacity
        self.cache = [:]
        self.keyQueue = Queue<Key>()
    }

    mutating func getValue(forKey key: Key) -> Value? {
        if let value = cache[key] {
            // 将最近使用的键移到队列的尾部
            keyQueue.enqueue(key)
            return value
        } else {
            return nil
        }
    }

    mutating func setValue(_ value: Value, forKey key: Key) {
        if cache[key] == nil {
            // 缓存中不存在该键，将新键加入队列尾部
            keyQueue.enqueue(key)
        }

        // 更新缓存值
        cache[key] = value

        // 如果缓存已满，移除最近最少使用的键
        if keyQueue.size > capacity {
            if let removedKey = keyQueue.dequeue() {
                cache[removedKey] = nil
            }
        }
    }
}

// 示例用法
var cache = LRUCache<String, Int>(capacity: 3)
cache.setValue(1, forKey: "a")
cache.setValue(2, forKey: "b")
cache.setValue(3, forKey: "c")
cache.setValue(4, forKey: "d")

print(cache.getValue(forKey: "a")) //nil
print(cache.getValue(forKey: "b")) //Optional(2)


//任务调度

///队列在任务调度中被用于管理待执行的任务。新任务可以添加到任务队列，而调度器可以从队列中取出任务并执行。
struct Task {
    var name: String
    var priority: Int
}

struct TaskScheduler {
    private var taskQueue: [Task]

    init() {
        self.taskQueue = []
    }

    mutating func addTask(_ task: Task) {
        taskQueue.append(task)
    }

    mutating func executeTasks() {
        taskQueue.sort(by: { $0.priority < $1.priority }) // 根据任务优先级排序数组

        for task in taskQueue {
            print("Executing task: \(task.name)")
        }

        taskQueue.removeAll() // 清空数组
    }
}

// 示例用法
var scheduler = TaskScheduler()
scheduler.addTask(Task(name: "Task 1", priority: 1))
scheduler.addTask(Task(name: "Task 2", priority: 2))
scheduler.addTask(Task(name: "Task 3", priority: 1))
scheduler.addTask(Task(name: "Task 4", priority: 3))

scheduler.executeTasks()
// Executing task: Task 1
// Executing task: Task 3
// Executing task: Task 2
// Executing task: Task 4
