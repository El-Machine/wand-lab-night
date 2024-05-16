//
//  Devices.swift
//  Bork
//
//  Created by Alex Kozin on 22.09.2020.
//  Copyright © 2020 El Machine. All rights reserved.
//

import CoreBluetooth

protocol PipableOptions {
    
    init()
    
}

protocol PipableWithOptions {
    
    associatedtype Options: PipableOptions
    
    static func |(piped: Self.Type, options: Options) -> Self
    
    init()
    
}

protocol PipableWithOperations {
    
    associatedtype Operations
    
    static func |(piped: Self, operation: Operations) -> Self
    
}

extension CBCentralManager: Pipable {
    
    typealias `Self` = CBCentralManager
    
    typealias In = CBPeripheral
    typealias Out = CBCentralManager
    
    struct Options: Pipable {
        
        var qos: DispatchQoS.QoSClass?
        var manager: [String: Any]?
        
        var services: [CBUUID]?
        var scan: [String : Any]?
        
    }
    
    @discardableResult
    static func |(piped: Self.Type, options: Options) -> CBCentralManager {
        let delegate = Delegate()
        delegate.pipe.put(options)
        
        let manager = delegate.pipe.get {
            CBCentralManager(delegate: delegate,
                             queue: .global(qos: options.qos ?? .utility),
                             options: options.manager)
        }
        
        return manager
    }
    
    enum Operations {
        case didConnect(_ handler: CBPeripheral.DidConnect)
//        case state(_ handler: (CBManagerState)->())

    }
    
    @discardableResult
    static func |(piped: Self, operation: Operations) -> CBCentralManager {
        switch operation {
            case .didConnect(let handler):
                (piped.delegate as! Delegate).didConnect = handler
                return piped
        }
    }
    
    @discardableResult
    static func |(piped: Self, handler: @escaping CBManagerState.Handler) -> CBCentralManager {
        (piped.delegate as! Delegate).didUpdateState = handler
        return piped
    }
    
    @discardableResult
    static func |(piped: Self, handler: CBPeripheral.Handler) -> CBCentralManager {
        let options: Options = piped.pipe.get()
        piped.scanForPeripherals(withServices: options.services,
                           options: options.scan)
        
        return piped
    }
    
    
    
    
}

extension CBPeripheral: Pipable {
    
    typealias `Self` = CBPeripheral
    typealias Handler = (Self, [String : Any], NSNumber)->()
    
    typealias DidConnect = (Self)->()
    
    
    @discardableResult
    static func |(piped: Self.Type, options: CBCentralManager.Options) -> CBCentralManager {
        CBCentralManager.self | options
    }

    @discardableResult
    static func |(piped: Self.Type, operation: CBCentralManager.Operations) -> CBCentralManager {
        CBCentralManager.self | .init() | operation
    }
    
    @discardableResult
    static func |(piped: Self.Type, handler: @escaping Handler) -> CBCentralManager {
        CBCentralManager.self | .init() | handler
    }
    
}

extension CBManagerState: Pipable {
    
    typealias `Self` = CBManagerState
    typealias Handler = (Self)->()
    
    @discardableResult
    static func |(piped: Self.Type, options: CBCentralManager.Options) -> CBCentralManager {
        CBCentralManager.self | options
    }
    
    @discardableResult
    static func |(piped: Self.Type, handler: @escaping Handler) -> CBCentralManager {
        CBCentralManager.self | .init() | handler
    }
    
}


extension CBCentralManager {
    
    class Delegate: NSObject, CBCentralManagerDelegate, Pipable {
        
        var didUpdateState: ((CBManagerState)->())?
        var didDiscover: CBPeripheral.Handler?
        var didConnect: CBPeripheral.DidConnect?

        
        func centralManagerDidUpdateState(_ central: CBCentralManager) {
            
            CBPeripheral.self | .init() | .didConnect { _ in
                
            }
            CBPeripheral.self | .didConnect { _ in
                
            }
            
            didUpdateState?(central.state)
        }
        
        func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
            didDiscover?(peripheral, advertisementData, RSSI)
        }
        
        func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
            didConnect?(peripheral)
        }
        
        func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
            
        }
        
        func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
            
        }
        
        func centralManager(_ central: CBCentralManager, connectionEventDidOccur event: CBConnectionEvent, for peripheral: CBPeripheral) {
            
        }
        
        func centralManager(_ central: CBCentralManager, didUpdateANCSAuthorizationFor peripheral: CBPeripheral) {
            
        }
        
    }
    
}

class Devices: NSObject {
    
    let service = CBUUID(string: "D973F2E0-B19E-11E2-9E96-0800200C9A66")
    
    static let shared = Devices()
    
    private var bluetooth = CBCentralManager(delegate: shared,
                                             queue: .global(qos: .utility),
                                             options: nil)
    
    func scan() {
        bluetooth.scanForPeripherals(withServices: [service],
                                     options: [CBCentralManagerScanOptionAllowDuplicatesKey: true])
        
    }
    
}

extension Devices: CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        guard advertisementData[CBAdvertisementDataIsConnectable] as? Bool == true else {
            return
        }
        
        
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        
    }
    
    func centralManager(_ central: CBCentralManager, connectionEventDidOccur event: CBConnectionEvent, for peripheral: CBPeripheral) {
        
    }
    
    func centralManager(_ central: CBCentralManager, didUpdateANCSAuthorizationFor peripheral: CBPeripheral) {
        
    }
    
}
