//: Protocol extensions
//: -------------------
//:
//: Protocol extension provides default implementation of method.
extension CollectionType {
    func myMap<U>(f: Self.Generator.Element -> U) -> [U] {
        var result: [U] = []
        for elt in self {
            result.append(f(elt))
        }
        return result
    }
}

[1, 2, 3, 4].myMap({ $0 * 2 })

//: Custom implementation will take precedence if it exists. Just like inheritance but you can not call default implementation if you override it.

protocol Printer {
    func letter() -> String //method can be defined in protocol but that's not necessary
}

extension Printer {
    func letter() -> String {
        return "?"
    }
}

class A: Printer {
    func letter() -> String {
        return "A"
    }
}

class B: Printer {
    func letter() -> String {
        return "B"
    }
}

class Б: Printer {
}

A().letter()
B().letter()
Б().letter()

//: Protocol extensions can solve problem of optional methods in pure Swift protocols providing default behaviour.

import UIKit

extension UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
}

//: Some global functions like filter, map, reduce, first, last, indexOf are now methods in protocol extensions (i.e. CollectionType extension).
//:
//: Swift 1.2:
//:
//:    map([1,2,3,4]){$0*2}
//:
//: Swift 2.0:
//:
[1,2,3,4].map {$0*2}

//:
//: Protocol extension constraints can be used instead of generic constraints in functions.
//:
func allOldSchool<S: SequenceType where S.Generator.Element: Equatable>(source: S, equalTo: S.Generator.Element) -> Bool {
    return !(source.contains{ $0 != equalTo })
}

extension SequenceType where Generator.Element: Equatable {
    func all(equalTo: Generator.Element) -> Bool {
        return !self.contains { $0 != equalTo }
    }
}

extension SequenceType {
    func all(criteria: Generator.Element -> Bool) -> Bool {
        return !self.contains { !criteria($0) }
    }
}

allOldSchool([true, false, true], equalTo: true)
[true, false, true].all(true)

struct User {
    let name: String
}
let ilya = User(name: "Ilya")
let marco = User(name: "Marco")
let card: [User] = [ilya, marco]
card.all {$0.name == "Ilya"}

//: [Next](@next)







