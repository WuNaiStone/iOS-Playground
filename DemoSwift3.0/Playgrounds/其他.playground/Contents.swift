//: Playground - noun: a place where people can play

import UIKit


"B" > "A"
"A" > "B"


// MARK - Other
var btn = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
btn.setTitle("Button", for: .normal)
btn.setTitleColor(UIColor.red, for: .normal)
btn.layer.borderColor = UIColor.blue.cgColor
btn.layer.borderWidth = 2.0
btn.layer.cornerRadius = 10.0
btn
btn is UIButton
btn is UILabel


UIColor.red
NSURL(string: "https://www.dianping.com")
var url = NSURL(string: "https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=4201714548,3253979110&fm=80")
UIImage(data: NSData(contentsOf: url as! URL) as! Data)


// 标签
var total = 0
outsideLoop: for i in 0..<20 {
    insideLoop: for j in 0..<20 {
        total += i + j
        if total > 3 {
            break outsideLoop
        }
    }
}


// typealias
typealias MyString = String
let str: MyString = "str"


typealias User = (name: String, age: Int)

func sayUser(_ user: User) {
    print("username : \(user.name)")
    print("age : \(user.age)")
}
let user: User = (name: "my name", age: 18)
sayUser(user)



NotificationCenter.default.addObserver(forName: Notification.Name("MyNotificationName"), object: nil, queue: nil) { (_) in
    
}

// 对NSNotification.name 进行extension
extension Notification.Name {
    static var MyNotificationName: Notification.Name {
        return Notification.Name("MyNotificationName")
    }
}

NotificationCenter.default.addObserver(forName: .MyNotificationName, object: nil, queue: nil) { _ in
}




