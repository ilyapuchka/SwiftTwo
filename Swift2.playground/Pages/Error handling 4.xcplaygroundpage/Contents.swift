//: [Previous](@previous)
/*:

In Swift 1.x we didn't have exceptions at all. In Swift 2.0 we can now throw and catch errors.

In ObjC we had:

     NSError *error;
     BOOL success = [data writeToFile: path options: options error: &error];
     if(!success) {
        // respond to the error somehow
        return;
     }

With exceptions we could have something like:

     @try {
     [data writeToFile: path options: options];
          // proceed normally
     } @catch(NSError *error) {
          // respond to the error somehow
     }

In Swift 2.0 we have:

     do {
        try data.writeToFile(path, options: options)
        // proceed normally
     } catch {
        // respond to the error somehow
     }
*/
/*:
Handling errors is checked at compile time. But it doesn't check what exact errors you handle. NSError from ObjC APIs is automatically mapped to new ErrorType, which is just an empty protocol. Every method that has NSError ** as last parameter is mapped to method that throws some ErrorType and has one less argument.
*/

import Foundation

func methodThatThrows(noError: Bool) throws -> String {
    if noError { return "Ok!" }
    throw NSError(domain: "domain", code: 0, userInfo: nil)
}

do {
    try methodThatThrows(false)
}
catch {
    print("Error")
}

//:
//: You have to annotate each single call to funcation that can throw error with `try`.
//: You can still ignore errors with `try!` when you know that error is impossible. But it will crash if error is thrown:
//:

try! methodThatThrows(true)

/*:
Using `try` without `do {} catch {}` we can pass error to outer context. If your function calls other failable function we can 'try' to call it without catching error and our function will throw whatever this other function throws:
*/

func otherMethod() throws -> Void {
    try methodThatThrows(false)
}

do {
    try otherMethod()
} catch { print("Error again!") }

//:
//: We can create our custom errors using enums:
//:

enum LoginError: ErrorType {
    case InvalidName
    case InvalidPassword
}

do { throw LoginError.InvalidName} catch { print(error) }

//:
//: or not:
//:

struct Error: ErrorType {
    // Required but currently undocumented (T_T)
    var _domain: String {return "com.wire"}
    var _code: Int {return 0}
    
    // Custom fields
    var reason: String
    var source: String
    
    // Initializer only requires a reason
    init(_ reason: String,
        source: String = __FUNCTION__,
        file: String = __FILE__,
        line: Int = __LINE__) {
            self.reason = reason
            self.source = "Thrown in \(source) (File: \(file) Line: \(line))"
    }
}

do { throw Error("Some error")} catch { print(error) }

//: [Next](@next)
