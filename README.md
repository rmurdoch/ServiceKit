# ServiceKit
Swift service library for reusable GET | POST | DELETE | PUT Request/Response protocols. Available to be extended to Objective-C classes if needed.  


# JsonWritable & JsonReadable & Wrapping Protocols
Protocols designed to read and write to NSObjects and Structs. 

Uses basic KVC for NSObjects and a Wrapping protocol for reading Structs.

if let value = valueMaybe as? Wrapping { }

extension String: Wrapping {
    public func wrap() -> AnyObject? {
        return self as AnyObject
    }
}


Allow requests to read to the correct response in each service call
associatedtype ResponseType: Response



# Service Layer
//Tests by: https://jsonplaceholder.typicode.com

Service method handleing Request protocols with generated Responses

internal func send<T:Request>(_ request:T, completion: @escaping (ResponseCompletion) -> ()) { }
