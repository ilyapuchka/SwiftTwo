//: [Previous](@previous)
//:
//: There are bunch of changes in standard library, most importan are:
//: * Finally we can use generic types as enum assiciated types without boxing:
//:

enum Either<T, U> {
    case Left(T)
    case Right(U)
}

let left : Either<Int, String> = Either.Left(1)
let right: Either<Int, String> = Either.Right("one")

//:
//: * You can now make specialized subclasses of generic classes:
//:

class GenericType<T> {
    func foo() -> T? {
        return nil
    }
}

class StringType: GenericType<String> {
    override func foo() -> String? {
        return "123"
    }
}

class IntType: GenericType<Int> {
    override func foo() -> Int? {
        return 123
    }
}

let general = GenericType<Int>()
general.foo()

let string = StringType()
string.foo()!

let integer = IntType()
integer.foo()!

//:
//: * Strings are not collections any more. But they still works the same. Collection representation is accessible in form of CharacterView via characters property.
//:

let ilya = "Ilya"
ilya.characters.count

//:
//: * do-while is now repeat-while
//:

var i = 3;
repeat {
    print("\(i)")
    i--
} while (i > 0)

//: * There are AnySequence, AnyGenerator and others to contain collection of any type. But you can not cast up to original type. Good when you want to hide some specifics of types used in collection from public api.

let set: Set = [1,2,3]
let array = [4,5,6]
let anySet = AnyForwardCollection(set)
let anyArray = AnyForwardCollection(array)
let anys = [anySet,anyArray]
let result = anys.flatMap { $0 }
print(result)

//:
//: * New API availability checking:
//:

if #available(iOS 10.0, *) {
    // something is available
    
} else {
    // Fallback on earlier versions
}