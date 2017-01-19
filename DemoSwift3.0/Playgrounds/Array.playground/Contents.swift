//: Playground - noun: a place where people can play

import UIKit

// MARK - Array

var array = Array<Int>()
array = [1,3,5,7,9,11]
for index in array {
    print(index)
}

for index in array.enumerated() {
    print(index)
}

array.append(13)
array[0...3]
array = [2,4,6,8,10]
for _ in 1...10 {
    print("say hello")
}

array = array.filter { (index) -> Bool in
    index % 4 == 0
}
print(array)

array = [2,4,6,8,10,1,5,11,20]
array.sort() // 默认排序
print(array)

array = [2,4,6,8,10,1,5,11,20]
array.sort { (x, y) -> Bool in
    x > y
}
print(array)

array = [2,4,6,8,10,1,5,11,20]
array = array.sorted()
print(array)

array = [2,4,6,8,10,1,5,11,20]
array = array.sorted(by: { (x, y) -> Bool in
    x > y
})
print(array)

array = [2,4,6,8,10,1,5,11,20]
array = array.sorted(by: {
    $0 > $1
})
print(array)

[100, 1, -5, 9, -20].sorted { (x, y) -> Bool in
    x*x < y*y
}

// 归纳
// 依次遍历每个element，执行指定操作，返回组成一个数组
// 在0的基础上，依次添加element
[1,2,3,4,5].reduce(0) { (result, element) -> Int in
    return result + element
}
// 在100的基础上，依次添加element
[1,2,3,4,5].reduce(100) { (result, element) -> Int in
    return result + element
}
// 去重
[1,2,3,1,2].reduce([]) { (result, element) -> [Int] in
    result.contains(element) ? result : result + [element]
}
// 去重
[1,2,3,1,2].reduce([]) {
    $0.contains($1) ? $0 : $0 + [$1]
}
// 去重
["a", "b", "c", "d", "e", "f", "a", "b"].reduce([]) {
    $0.contains($1) ? $0 : $0 + [$1]
}
// 去重
["a", "b", "c", "d", "e", "f", "a", "b"].reduce([]) { (result, element) -> [String] in
    result.contains(element) ? result : result + [element]
}



var arr1 = ["a", "b", "c", "d", "e", "f"]
var arr2 = ["g", "h", "i", "j"]
arr1 += arr2
arr2 += arr1


var arr = [1,2,3].reversed()
Array(arr)


