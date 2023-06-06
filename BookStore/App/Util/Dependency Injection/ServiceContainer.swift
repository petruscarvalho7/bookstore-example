//
//  ServiceContainer.swift
//  BookStore
//
//  Created by Petrus Carvalho on 05/06/23.
//

import Foundation

final class ServiceContainer {
    
    private static var cache: [String: Any] = [:]
    private static var generators: [String: () -> Any] = [:]
    
    static func register<Service>(type: Service.Type, as serviceType: ServiceType = .singleton, _ factory: @autoclosure @escaping () -> Service) {
        generators[String(describing: type.self)] = factory
        
        if serviceType == .singleton {
            cache[String(describing: type.self)] = factory()
        }
    }
    
    static func resolve<Service>(dependencyType: ServiceType = .singleton, _ type: Service.Type) -> Service? {
        let key = String(describing: type.self)
        switch dependencyType {
        case .singleton:
            if let cachedService = cache[key] as? Service {
                return cachedService
            } else {
                fatalError("\(String(describing: type.self)) is not registeres as singleton")
            }
            
        case .automatic:
            if let cachedService = cache[key] as? Service {
                return cachedService
            }
            fallthrough
            
        case .newInstance:
            if let service = generators[key]?() as? Service {
                cache[String(describing: type.self)] = service
                return service
            } else {
                return nil
            }
        }
    }
}
