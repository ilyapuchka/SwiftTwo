//: [Previous](@previous)
/*:

* XCode 7 feature - Generated Interface menu item in related items menu will show generated Swift interface from your ObjC header.


* New @nonobjc attribute prevents to expose simbols from Swift to ObjC.
*/
import Foundation

class Controller: NSObject {
    func doSome(x: Int) {
    }
    
    @objc(doSomeWithDouble:) // will be accessible in Obj-C code as doSomeWithDouble: method
    func doSome(x: Double) {
    }
}

class OtherController: NSObject {
    func doSome(x: Int) {
    }
    
    @nonobjc // will be not accessible in Obj-C code
    func doSome(x: Double) {
    }
}
/*: * ObjC now has lightweight generics. It is just a compiler feature, not runtime, compiler deletes additional information at the end. So you can not access type information at runtime. But the type information is imported to Swift.
*/
//:    @property NSArray<NSDate *>* dates;
//:    @property NSSet<NSString *>* words;
//:    @property NSDictionary<KeyType: NSURL *, NSData *>* cachedData;
/*:
Swift will import that as:

    var dates: [NSDate]
    var words: Set<String>
    var cachedData: [NSURL: NSData]

You can not use generics with other classes, only NSArray, NSSet, NSDictionary. Others are ignored by Swift like if there were no type information at all.


* Instead of id we can now use __kindof SomeClass X to tell that X is some subclass of SomeClass:

__kindof MyClass *object = [MySubclass new];
NSObject *nsObj = object; //Ok
MySybclass *myObj = object; //Ok
NSString *string = object; // Will produce warning

Instead of this:

- (nullable id)someMethod; // Obj-C

func someMethod() -> AnyObject? // Swift

We can have this:

- (nullable UIView *)someMethod; // Obj-C

func someMethod() -> UIView? // Swift

It can be also used with generics:

@interface UIView @property(nonatomic,readonly,copy) NSArray<__kindof UIView *> *subviews; 
@end   Best practices for using __kindof: @property(nonatomic,readonly,copy) NSArray<_  _kindof UIView *> *subviews; @end 

Best practices:

* instancetype for methods that return “self”* Typed collections for most collections* __kindof X * for “some subclass of X”* id<SomeProtocol> for any type that conforms to SomeProtocol

*/
//: [Next](@next)
