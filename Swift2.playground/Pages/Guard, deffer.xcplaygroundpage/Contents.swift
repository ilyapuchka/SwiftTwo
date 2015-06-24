//: [Previous](@previous)
//:
//: Guard and defer.
//: ----------------
//:
//: Guard statement let's you check optional values for nil and handle them earlier. If the condition passes, the optional variable here is already unwrapped for current scope.
//:
//: In Swift 1.2:
//:

func fooBinding(x: Int?) {
    if let x = x where x > 0 {
        x.description
    }
    // Value requirements not met, do something
}

fooBinding(1)
fooBinding(2)
fooBinding(-1)
fooBinding(nil)

//:
//: In Swift 2.0:
//:

func fooGuard(x: Int?) {
    guard let x = x where x > 0 else {
        // Value requirements not met, do something
        return
    }
    x.description
}

fooGuard(1)
fooGuard(2)
fooGuard(-1)
fooGuard(nil)

//:
//: Defer statement provides block of code that will be executed before execution leaves current scope. So you can do any cleanup which will be performed anyway before you leave a scope (i.e. a function, or if block) regardles of how you leave the scope, with error, by return or just by getting to it's ent.
//:

func useDefer(x: Int) {
    var logs = [String]()
    defer {
        logs.append("defer 1")
        logs
    }
    
    if x < 0 {
        return
    }
    else {
        defer {
            logs.append("defer 2")
            logs
        }
        defer {
            logs.append("defer 3")
            logs
        }
    }
    
    defer {
        logs.append("defer 4")
        logs
    }
    
}

useDefer(2)

//: [Next](@next)
