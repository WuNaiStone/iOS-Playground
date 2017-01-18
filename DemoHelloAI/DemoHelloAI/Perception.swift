//
//  Perceptron.swift
//  DemoHelloAI
//
//  Created by Chris Hu on 17/1/18.
//  Copyright © 2017年 com.icetime17. All rights reserved.
//

import UIKit


struct Perception {
    // 权重
    var weights: [Float]
    
    init() {
        weights = [Float]()
        
        // 输入x，y，则另外需要一个权重值来调整偏差
        for _ in 0...2 {
            // -1, 0, 1
            let randWeight = Int(arc4random()) % 3 - 1
            weights.append(Float(randWeight))
        }
        print("initial weights: \(weights)")
    }
    
    
    // 根据inputs，结合权重值，执行加权求和
    func feedback(inputs: [Float]) -> Int {
        var sum: Float = 0.0
        for index in 0..<weights.count {
            sum += inputs[index] * weights[index]
        }
        
        return judge(sum: sum)
    }
    
    
    // 判断结果
    func judge(sum: Float) -> Int {
        return sum > 0 ? 1 : -1
    }
    
    
    // 如何训练感知器，调整weights权重值
    // 提供输入及预期结果，不断进化weights值
    var c: Float = 0.01
    mutating func train(inputs: [Float], desired: Int) {
        let guess = feedback(inputs: inputs)
        let errorOffset = desired - guess
        
        for index in 0..<weights.count {
//            print("\(inputs[index]) : weight is \(weights[index])")
            weights[index] += c * Float(errorOffset) * inputs[index]
//            print("\(inputs[index]) : weight is \(weights[index])")
        }
        
//        print("")
    }
}



