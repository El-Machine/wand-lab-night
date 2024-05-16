//
//  CoreMotion+Pipe.swift
//  Run
//
//  Created by Alex Kozin on 04.10.2020.
11(
//

import CoreMotion.CMPedometer

protocol Pipable: Associatable {
    
    var pipe: Pipe {get}
    
}

extension Pipable {
    
    var pipe: Pipe {
        get {
            association(for: "pipe") {
                let pipe = Pipe()
                pipe[Self.self] = self
                
                return pipe
            }
        }
        set {
            associate(newValue, for: "pipe")
        }
    }
    
}

postfix func |(piped: Pipable) {
    piped.pipe.close()
}

class Pipe {
    
    private var objects = [String: Any]()
    
    fileprivate subscript<P>(class: P.Type) -> P? {
        get {
            objects[String(describing: P.self)] as? P
        }
        set {
            objects[String(describing: P.self)] = newValue
        }
    }
    
    func get<P: Pipable>(create: ()->(P)) -> P {
        (self[P.self]) ?? {
            var piped = create()
            piped.pipe = self
            
            self[P.self] = piped
            
            return piped
        }()
    }
    
    func get<P: Pipable>() -> P {
        self[P.self]!
    }
    
    
    @discardableResult
    func put<P: Pipable>(_ value: P) -> P {
        self[P.self] = value

        return value
    }
    
    func close() {
        objects.removeAll()
    }
    
    //    private var error: Error?
    ////    private var completion: (Any)->()
    //
    //    func error(handler: (Error)->()) -> Pipe {
    //        Pipe()
    //    }
    
    //    @discardableResult
    //    static func |(pipe: Pipe, handler: Pipe) -> Pipe {
    //        return pipe
    //    }
    //
    //    mutating func error(happend error: Error?) -> Bool {
    //        self.error = error
    //        return error == nil
    //    }
    
}

extension Error {
    
    @discardableResult
    static func |(pipe: Pipe, handler: Error) -> Pipe {
        return pipe
    }
    
}


protocol PipableTo: Pipable {
    
    associatedtype T: PipableWithOptions & PipableWithOperations
    associatedtype Handler
    
    @discardableResult
    static func |(piped: Self.Type, options: T.Options) -> T
    
    @discardableResult
    static func |(piped: Self.Type, operation: T.Operations) -> T
    
    @discardableResult
    static func |(piped: Self.Type, handler: Handler) -> T
    
}

extension PipableTo {
    
    static func |(piped: Self, options: T.Options) -> T {
        T.self | options
    }
    
    static func |(piped: Self, operation: T.Operations) -> T {
        T.self | .init() | operation
    }
    
}


//extension CMPedometer: Pipable {
//    
//}
//
//extension CMPedometerData: Pipable {
//    
//    @discardableResult
//    static func |(piped: CMPedometerData, handler: @escaping (CMPedometerData)->()) -> CMPedometer? {
//        let pedometer = piped.pipe.get {
//            CMPedometer()
//        }
//        
//        pedometer.startUpdates(from: Date()) { (data, error) in
//            handler(data!)
//        }
//        
//        return pedometer
//    }
//    
//}
//
//extension CMPedometerEvent: Pipable {
//    
//    @discardableResult
//    static func |(piped: CMPedometerEvent, handler: @escaping (CMPedometerEvent)->()) -> CMPedometer? {
//        let pedometer = piped.pipe.get {
//            CMPedometer()
//        }
//        
//        pedometer.startEventUpdates { (event, error) in
//            if let event = event {
//                handler(event)
//            }
//        }
//        
//        return pedometer
//    }
//    
//}

extension CMPedometer: Pipable {

    static func event(_ handler: @escaping (CMPedometerEvent)->()) -> CMPedometer {
        let p = CMPedometer()
        p.startEventUpdates { (event, error) in
            if let event = event {
                handler(event)
            }
        }
        
        return p
    }
    
    static func data(_ handler: @escaping (CMPedometerData)->()) -> CMPedometer {
        let p = CMPedometer()
        p.startUpdates(from: Date()) { (data, error) in
            handler(data!)
        }
        
        return p
    }
    
}

extension CMPedometerData: Pipable {
    
    typealias `Self` = CMPedometerData
    
    @discardableResult
    static func |(piped: Self.Type, handler: @escaping (Self)->()) -> CMPedometer {
        CMPedometer.data(handler)
    }
    
}

extension CMPedometerEvent: Pipable {
    
    typealias `Self` = CMPedometerEvent
    
    @discardableResult
    static func |(piped: Self.Type, handler: @escaping (Self)->()) -> CMPedometer {
        CMPedometer.event(handler)
    }
    
}
