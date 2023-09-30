//
//  ReachabilityService.swift
//  simpleExchangeRate
//
//  Created by Alexey Krzywicki on 30.09.2023.
//

import Foundation
import SystemConfiguration

struct ReachabilityService {
    
    private let semaphore = DispatchSemaphore(value: 1)
    
    func isInternetAvailable() -> Bool {
        
        semaphore.wait()
        defer {
            semaphore.signal()
        }
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
}

