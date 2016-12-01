//: Playground - noun: a place where people can play

import UIKit

// MARK - 运算符重载
// 中间：计算平方和，左结合，优先级255
infix operator +++ {associativity left precedence 255}

func +++(left: Double, right: Double) -> Double {
    return left*left + right*right
}

print(1+++3)


// MARK - GPUImage相关
infix operator ---> {associativity left precedence 255}
func --->(left: GPUImageOutput, right: GPUImageInput) {
    left.addTarget(right)
}
stillCamera.addTarget(cameraView)
stillCamera--->cameraView

