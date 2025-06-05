//
//  Model.swift
//  WWSystemStatus
//
//  Created by William.Weng on 2025/6/5.
//

import Foundation

public extension WWSystemStatus {
    
    /// JSON主結構
    struct SystemStatus: Decodable {
        let drpost: Bool
        let drMessage: String?
        let services: [Service]
    }
    
    /// JSON子結構
    struct Service: Decodable {
        let serviceName: String
        let redirectUrl: String?
        let events: [String]
    }
}
