//: [Previous](@previous)
//:
//: Pattern matching and filtering improvements.
//: --------------------------------------------
//:
//: 1. Filtering in for..in loops
//:
for even in 0..<10 {
    if even % 2 == 0 { even }
}

let isEven = { $0%2 == 0 }
for even in 0..<10 where isEven(even) {even}

//:
//: Using this together with protocol extension:
//:
extension IntegerLiteralType {
    func isEven() -> Bool {
        return self % 2 == 0
    }
}

for even in 0..<10 where even.isEven() {
    print(even)
}

//:
//: 2. Pattern matching in for..in loop. Will loop only items that match with pattern
//:

let taylorSwiftAlbumsWithYear = [
    ("Red", 2014),
    ("1989", 2014),
    ("Fearless", 2008),
    ("Speak Now", 2008)]

//:
//: Swift 1.2:
//:
for item in taylorSwiftAlbumsWithYear {
    switch item {
    case (let album, 2014): print("Taylor Swift's album \(album) was released in 2014")
    default: break
    }
}
//:
//: Swift 2.0:
//:
for case let (album, 2014) in taylorSwiftAlbumsWithYear {
    print("Taylor Swift's album \(album) was released in 2014")
}

//:
//: 3. Filtering enums. For Dasha with love:
//:

enum Food {
    case Vegetarian(String)
    case Ordinary(String)
}

let fridge : [Food] = [.Vegetarian("apple"), .Vegetarian("banana"), .Ordinary("pork")]
for case let .Vegetarian(DashaLikesThis) in fridge {
    print(DashaLikesThis)
}

//:
//: 4. Now we can filter optionals!
//:

let numbersWithOptions: [Int?] = [nil, 1,2,4, nil, 6]

for case let .Some(number) in numbersWithOptions {
    print(number)
}


//: But there is better way:

for case let number? in numbersWithOptions {
    print(number)
}

//: This looks more natural in switch:

var username: String?
var password: String?

switch (username, password) {
case let (username?, password?):
    print("Success!")
case let (username?, nil):
    print("Password is missing")
case let (nil, password?):
    print("Username is missing")
case (nil, nil):
    print("Both username and password are missing")
}

//:
//: 5. Pattern matching in if:
//:

func minionsWillLike(this: Food) -> Bool {
    if case .Vegetarian(let food) = this where food == "banana" {
        return true
    }
    return false
}

fridge.map(minionsWillLike)

//:
//: You can match in if the same way like in switch even using some advanced pattern matching techniques:
//:

let numberOfGuests = 10
if case 0..<20 = numberOfGuests {
    print("That's enough for good party")
}
else if case 20..<Int.max = numberOfGuests {
    print("This party rocks!")
}

//: [Next](@next)
