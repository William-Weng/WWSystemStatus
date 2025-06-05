//
//  Extension.swift
//  WWSystemStatus
//
//  Created by William.Weng on 2025/6/5.
//

import UIKit

// MARK: - Data (function)
extension Data {
        
    /// Data => Class
    /// - Parameter type: 要轉型的Type => 符合Decodable
    /// - Returns: T => 泛型
    func _class<T: Decodable>(type: T.Type) -> T? {
        let modelClass = try? JSONDecoder().decode(type.self, from: self)
        return modelClass
    }
}
