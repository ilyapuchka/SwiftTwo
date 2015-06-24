//: [Previous](@previous)
//:
//: OptionSetType
//: -------------
//:
//: No more binary logic, just use set-like functions:
//:

import UIKit

var options = UIRectEdge()
options.insert(.Left)
options.contains(.Left)
options.contains(.Right)
options.unionInPlace([.Right, .Bottom])
options.contains(.Right)

//: Options set in fact is a struct derived from OptionSetType with static constants as options and some rawValue:

struct Directions: OptionSetType {
    let rawValue: Int //this is a generic constraint of RawRepresentable protocol
    
    static let Up = Directions(rawValue: 1)
    static let Down = Directions(rawValue: 2)
    static let Left = Directions(rawValue: 3)
    static let Right = Directions(rawValue: 4)
    
    static let UpRight : Directions = [.Up, .Right]
    static let UpLeft : Directions = [.Up, .Left]
    static let DownRight : Directions = [.Down, .Right]
    static let DownLeft : Directions = [.Down, .Left]
}

//: [Next](@next)
