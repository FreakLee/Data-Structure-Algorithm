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

